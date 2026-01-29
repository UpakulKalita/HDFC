import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/recommendation.dart';

abstract class DashboardRepository {
  Future<List<DashboardMetric>> getProtectionScoreMetrics();
  Future<List<Recommendation>> getRecommendations();
}
