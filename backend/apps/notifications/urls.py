from django.urls import path

from .views import (
    FCMTokenView,
    NotificationListView,
    NotificationReadAllView,
    NotificationReadView,
    NotificationSettingsView,
)

urlpatterns = [
    path("notifications/", NotificationListView.as_view(), name="notification-list"),
    path("notifications/read-all", NotificationReadAllView.as_view(), name="notification-read-all"),
    path("notifications/settings", NotificationSettingsView.as_view(), name="notification-settings"),
    path("notifications/fcm-token", FCMTokenView.as_view(), name="fcm-token"),
    path("notifications/<int:pk>/read", NotificationReadView.as_view(), name="notification-read"),
]
