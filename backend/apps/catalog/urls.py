from django.urls import path

from .views import (
    BranchDetailView,
    BranchListView,
    ServiceCategoryListView,
    ServiceDetailView,
    ServiceListView,
)

urlpatterns = [
    path("services", ServiceListView.as_view(), name="service-list"),
    # NOTE: must come before services/<int:pk> would never clash (int converter),
    # but keep it explicit and above for clarity.
    path("services/categories", ServiceCategoryListView.as_view(), name="service-categories"),
    path("services/<int:pk>", ServiceDetailView.as_view(), name="service-detail"),
    path("branches", BranchListView.as_view(), name="branch-list"),
    path("branches/<int:pk>", BranchDetailView.as_view(), name="branch-detail"),
]
