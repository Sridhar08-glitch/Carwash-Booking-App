from rest_framework import serializers

from .models import Branch, BranchHours, Service, ServiceCategory


class ServiceCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = ServiceCategory
        fields = ["id", "name", "slug", "description", "ordering"]


class ServiceSerializer(serializers.ModelSerializer):
    category = ServiceCategorySerializer(read_only=True)
    category_id = serializers.PrimaryKeyRelatedField(
        queryset=ServiceCategory.objects.all(), source="category", write_only=True
    )

    class Meta:
        model = Service
        fields = [
            "id", "category", "category_id", "name", "slug", "description",
            "base_price", "currency", "duration_minutes", "image",
            "tags", "is_mobile_available", "is_active",
        ]
        read_only_fields = ["id"]


class BranchHoursSerializer(serializers.ModelSerializer):
    class Meta:
        model = BranchHours
        fields = ["weekday", "open_time", "close_time", "is_closed"]


class BranchSerializer(serializers.ModelSerializer):
    hours = BranchHoursSerializer(many=True, read_only=True)

    class Meta:
        model = Branch
        fields = [
            "id", "name", "address", "city", "lat", "lng",
            "timezone", "phone", "is_active", "hours",
        ]
        read_only_fields = ["id"]
