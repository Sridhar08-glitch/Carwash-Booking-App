"""Catalog views — read-only for customers; write via Django admin in Phase 1."""
from django.core.cache import cache
from drf_spectacular.utils import extend_schema, OpenApiParameter
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.pagination import CursorPagination

from .selectors import (
    get_active_branches,
    get_active_services,
    get_branch_by_id,
    get_service_by_id,
    get_service_categories,
)
from .serializers import BranchSerializer, ServiceCategorySerializer, ServiceSerializer


class ServiceListView(APIView):
    """GET /api/v1/services/ — list active services, optionally filtered by category."""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        parameters=[OpenApiParameter("category", str, description="Filter by category slug")],
        responses={200: ServiceSerializer(many=True)},
        tags=["services"],
        summary="List services",
    )
    def get(self, request: Request) -> Response:
        tenant_id = request.user.tenant_id
        category = request.query_params.get("category")  # slug or numeric id
        cache_key = f"services:{tenant_id}:{category or 'all'}"

        data = cache.get(cache_key)
        if data is None:
            qs = get_active_services(tenant_id=tenant_id, category=category)
            data = ServiceSerializer(qs, many=True).data
            cache.set(cache_key, data, timeout=300)
        return Response(data)


class ServiceDetailView(APIView):
    """GET /api/v1/services/{id}/"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: ServiceSerializer}, tags=["services"], summary="Get service detail")
    def get(self, request: Request, pk: int) -> Response:
        service = get_service_by_id(tenant_id=request.user.tenant_id, service_id=pk)
        if service is None:
            from apps.common.errors import NotFoundError
            raise NotFoundError("Service not found.")
        return Response(ServiceSerializer(service).data)


class BranchListView(APIView):
    """GET /api/v1/branches/ — list active branches."""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: BranchSerializer(many=True)}, tags=["branches"], summary="List branches")
    def get(self, request: Request) -> Response:
        tenant_id = request.user.tenant_id
        cache_key = f"branches:{tenant_id}"
        data = cache.get(cache_key)
        if data is None:
            qs = get_active_branches(tenant_id=tenant_id)
            data = BranchSerializer(qs, many=True).data
            cache.set(cache_key, data, timeout=300)
        return Response(data)


class BranchDetailView(APIView):
    """GET /api/v1/branches/{id}/"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: BranchSerializer}, tags=["branches"], summary="Get branch detail")
    def get(self, request: Request, pk: int) -> Response:
        branch = get_branch_by_id(tenant_id=request.user.tenant_id, branch_id=pk)
        if branch is None:
            from apps.common.errors import NotFoundError
            raise NotFoundError("Branch not found.")
        return Response(BranchSerializer(branch).data)


class ServiceCategoryListView(APIView):
    """GET /api/v1/services/categories — list active service categories."""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: ServiceCategorySerializer(many=True)},
        tags=["services"],
        summary="List service categories",
    )
    def get(self, request: Request) -> Response:
        tenant_id = request.user.tenant_id
        cache_key = f"service_categories:{tenant_id}"
        data = cache.get(cache_key)
        if data is None:
            qs = get_service_categories(tenant_id=tenant_id)
            data = ServiceCategorySerializer(qs, many=True).data
            cache.set(cache_key, data, timeout=300)
        return Response(data)
