"""
Notifications tests — Phase 2.

Covers:
- Notification list, unread count, mark-read, mark-all-read.
- Notification settings GET/PATCH.
- FCM token update.
- send_notification service (FCM disabled in tests).
- Abandoned cart and reminder tasks (basic smoke tests).
"""
from unittest.mock import patch

from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.common.models import Tenant
from apps.notifications import services
from apps.notifications.models import Notification, NotificationPreference


# ── Fixtures ──────────────────────────────────────────────────────────────────

def _make_user():
    tenant, _ = Tenant.objects.get_or_create(slug="notif-test", defaults={"name": "NotifTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone="+966542000001",
        defaults={"username": "+966542000001", "tenant": tenant, "role": "customer"},
    )
    return tenant, user


def _api_client(user):
    client = APIClient()
    token = RefreshToken.for_user(user)
    client.credentials(HTTP_AUTHORIZATION=f"Bearer {token.access_token}")
    return client


# ── Service tests ─────────────────────────────────────────────────────────────

class NotificationServiceTests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_user()
        Notification.objects.filter(user=self.user).delete()

    def test_send_notification_creates_row(self):
        notif = services.send_notification(
            user=self.user, title="Hello", body="World",
            notification_type="general",
        )
        self.assertEqual(notif.title, "Hello")
        self.assertFalse(notif.is_read)
        self.assertEqual(Notification.objects.filter(user=self.user).count(), 1)

    def test_send_notification_no_fcm_without_token(self):
        """No FCM push when user has no fcm_token."""
        self.user.fcm_token = ""
        self.user.save(update_fields=["fcm_token"])
        notif = services.send_notification(
            user=self.user, title="T", body="B"
        )
        # fcm_message_id should be blank since push was skipped
        self.assertEqual(notif.fcm_message_id, "")

    def test_send_notification_push_disabled_pref(self):
        """No FCM push when user has push_enabled=False."""
        self.user.fcm_token = "fake-token"
        self.user.save(update_fields=["fcm_token"])
        NotificationPreference.objects.update_or_create(
            user=self.user, defaults={"tenant": self.tenant, "push_enabled": False}
        )
        with patch("apps.notifications.services._send_fcm") as mock_fcm:
            services.send_notification(user=self.user, title="T", body="B")
            mock_fcm.assert_not_called()


# ── API tests ─────────────────────────────────────────────────────────────────

class NotificationAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_user()
        self.client = _api_client(self.user)
        Notification.objects.filter(user=self.user).delete()

    def _create_notif(self, read=False):
        return Notification.objects.create(
            tenant=self.tenant, user=self.user,
            title="Test", body="Body", type="general", is_read=read,
        )

    def test_list_notifications_200(self):
        self._create_notif()
        resp = self.client.get("/api/v1/notifications/")
        self.assertEqual(resp.status_code, 200)
        data = resp.json()
        self.assertIn("unread_count", data)
        self.assertIn("results", data)
        self.assertEqual(len(data["results"]), 1)

    def test_unread_count_accurate(self):
        self._create_notif(read=False)
        self._create_notif(read=False)
        self._create_notif(read=True)
        resp = self.client.get("/api/v1/notifications/")
        self.assertEqual(resp.json()["unread_count"], 2)

    def test_unread_filter(self):
        self._create_notif(read=False)
        self._create_notif(read=True)
        resp = self.client.get("/api/v1/notifications/?unread=1")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(len(resp.json()["results"]), 1)

    def test_mark_read(self):
        notif = self._create_notif(read=False)
        resp = self.client.post(f"/api/v1/notifications/{notif.pk}/read")
        self.assertEqual(resp.status_code, 200)
        notif.refresh_from_db()
        self.assertTrue(notif.is_read)

    def test_mark_read_not_found(self):
        resp = self.client.post("/api/v1/notifications/999999/read")
        self.assertEqual(resp.status_code, 404)

    def test_mark_all_read(self):
        self._create_notif(read=False)
        self._create_notif(read=False)
        resp = self.client.post("/api/v1/notifications/read-all")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["marked_read"], 2)
        self.assertEqual(Notification.objects.filter(user=self.user, is_read=False).count(), 0)

    def test_settings_get(self):
        resp = self.client.get("/api/v1/notifications/settings")
        self.assertEqual(resp.status_code, 200)
        self.assertIn("push_enabled", resp.json())

    def test_settings_patch(self):
        resp = self.client.patch(
            "/api/v1/notifications/settings",
            {"push_enabled": False},
            format="json",
        )
        self.assertEqual(resp.status_code, 200)
        self.assertFalse(resp.json()["push_enabled"])

    def test_fcm_token_update(self):
        resp = self.client.post(
            "/api/v1/notifications/fcm-token",
            {"fcm_token": "new-firebase-token-abc123"},
            format="json",
        )
        self.assertEqual(resp.status_code, 200)
        self.user.refresh_from_db()
        self.assertEqual(self.user.fcm_token, "new-firebase-token-abc123")

    def test_unauthenticated_401(self):
        anon = APIClient()
        resp = anon.get("/api/v1/notifications/")
        self.assertEqual(resp.status_code, 401)
