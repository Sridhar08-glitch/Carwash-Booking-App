"""Cursor-based pagination for all list endpoints."""
from rest_framework.pagination import CursorPagination as _CursorPagination
from rest_framework.response import Response


class CursorPagination(_CursorPagination):
    """
    Default cursor pagination.

    Returns a consistent envelope:
    {
        "next": "<cursor_url | null>",
        "previous": "<cursor_url | null>",
        "results": [...]
    }
    """

    page_size = 20
    page_size_query_param = "page_size"
    max_page_size = 100
    ordering = "-created_at"

    def get_paginated_response(self, data):
        return Response(
            {
                "next": self.get_next_link(),
                "previous": self.get_previous_link(),
                "count": None,  # cursor pagination doesn't count; use analytics API
                "results": data,
            }
        )

    def get_paginated_response_schema(self, schema):
        return {
            "type": "object",
            "properties": {
                "next": {"type": "string", "nullable": True},
                "previous": {"type": "string", "nullable": True},
                "count": {"type": "integer", "nullable": True},
                "results": schema,
            },
            "required": ["results"],
        }
