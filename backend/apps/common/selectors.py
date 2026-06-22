"""Read-only queries for the common app."""
from __future__ import annotations

from uuid import UUID


def get_home_layout(*, tenant_id: UUID | str | None) -> list[dict]:
    """
    Return ordered home-screen sections for the given tenant.

    Phase 1: returns a hard-coded skeleton that ops can manage via admin
    once HomeSection model (below) is added in Phase 2.
    """
    # TODO (Phase 2): query HomeSection.objects.filter(tenant_id=tenant_id, is_active=True)
    return [
        {
            "type": "hero_banner",
            "id": "hero-1",
            "data": {
                "title": "Welcome to Sridhar Car Wash",
                "subtitle": "Premium car care at your doorstep",
                "image_url": None,
                "cta_label": "Book Now",
                "cta_action": "navigate:booking",
            },
        },
        {
            "type": "service_rail",
            "id": "services-1",
            "data": {"title": "Our Services", "source": "api:services"},
        },
        {
            "type": "offer_strip",
            "id": "offers-1",
            "data": {"items": []},
        },
    ]
