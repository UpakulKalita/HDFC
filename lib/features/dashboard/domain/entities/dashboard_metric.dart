import 'package:equatable/equatable.dart';

class DashboardMetric extends Equatable {
  final String label;
  final String value;
  final String status;
  final double progress;
  final String? currentCoverage;
  final String? targetCoverage;

  const DashboardMetric({
    required this.label,
    required this.value,
    this.status = 'Good',
    this.progress = 0.0,
    this.currentCoverage,
    this.targetCoverage,
  });

  @override
  List<Object?> get props => [label, value, status, progress, currentCoverage, targetCoverage];
}
