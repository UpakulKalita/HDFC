import 'package:insurance_flutter/features/dashboard/data/models/dashboard_metric_model.dart';

const List<DashboardMetricModel> mockCoverageMetrics = [
  DashboardMetricModel(
    label: 'Health', 
    value: 'Underinsured', 
    status: 'Critical', 
    progress: 0.5,
    currentCoverage: '₹30L',
    targetCoverage: '₹50L',
  ),
  DashboardMetricModel(
    label: 'Term Life', 
    value: 'Adequate',
    status: 'Good', 
    progress: 0.94,
    currentCoverage: '₹80L',
    targetCoverage: '₹1Cr',
  ),
];
