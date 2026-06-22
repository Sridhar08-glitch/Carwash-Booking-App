"""
DRF permission classes.

IsCustomer   — role == 'customer'
IsStaff      — role == 'staff'   (car-wash staff, not Django staff flag)
IsAdmin      — role == 'admin'
IsOwner      — object-level check: object.user == request.user (or tenant match)

Role checks are centralised here; view bodies never inspect request.user.role.
"""
from rest_framework.permissions import BasePermission, IsAuthenticated


class RolePermission(IsAuthenticated):
    """Base class: require auth + a specific role."""

    allowed_roles: tuple[str, ...] = ()

    def has_permission(self, request, view):
        if not super().has_permission(request, view):
            return False
        return request.user.role in self.allowed_roles


class IsCustomer(RolePermission):
    allowed_roles = ("customer",)


class IsStaff(RolePermission):
    """Car-wash staff (not Django's is_staff flag)."""
    allowed_roles = ("staff",)


class IsAdmin(RolePermission):
    allowed_roles = ("admin",)


class IsCustomerOrAdmin(RolePermission):
    allowed_roles = ("customer", "admin")


class IsStaffOrAdmin(RolePermission):
    allowed_roles = ("staff", "admin")


class IsOwner(BasePermission):
    """
    Object-level: the object must have a `.user` attribute equal to the
    requesting user, OR the requesting user is an admin.

    Usage:
        permission_classes = [IsAuthenticated, IsOwner]
    """

    def has_object_permission(self, request, view, obj):
        if request.user.role == "admin":
            return True
        owner = getattr(obj, "user", None) or getattr(obj, "customer", None)
        return owner == request.user


class IsTenantMember(IsAuthenticated):
    """Object-level: object.tenant_id == request.user.tenant_id."""

    def has_object_permission(self, request, view, obj):
        return str(getattr(obj, "tenant_id", None)) == str(
            getattr(request.user, "tenant_id", None)
        )
