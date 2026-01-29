import 'package:insurance_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/recommendation.dart';
import 'package:insurance_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<List<DashboardMetric>> getProtectionScoreMetrics() async {
    return await localDataSource.getProtectionScoreMetrics();
  }

  @override
  Future<List<Recommendation>> getRecommendations() async {
    return await localDataSource.getRecommendations();
  }
}
