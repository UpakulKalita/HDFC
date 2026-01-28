import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/recommendation.dart';
import 'package:insurance_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository repository;

  List<DashboardMetric> _metrics = [];
  List<Recommendation> _recommendations = [];
  bool _isLoading = false;
  String? _error;

  DashboardProvider({required this.repository});

  List<DashboardMetric> get metrics => _metrics;
  List<Recommendation> get recommendations => _recommendations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        repository.getProtectionScoreMetrics(),
        repository.getRecommendations(),
      ]);

      _metrics = results[0] as List<DashboardMetric>;
      _recommendations = results[1] as List<Recommendation>;
    } catch (e) {
      _error = 'Failed to load dashboard data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
