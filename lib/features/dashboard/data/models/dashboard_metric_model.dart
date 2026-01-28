import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';

class DashboardMetricModel extends DashboardMetric {
  const DashboardMetricModel({
    required super.label,
    required super.value,
    super.status,
    super.progress,
  });

  factory DashboardMetricModel.fromJson(Map<String, dynamic> json) {
    return DashboardMetricModel(
      label: json['label'],
      value: json['value'],
      status: json['status'] ?? 'Good',
      progress: (json['progress'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'status': status,
      'progress': progress,
    };
  }
}
