import 'package:equatable/equatable.dart';

class DashboardMetric extends Equatable {
  final String label;
  final String value;
  final String status; // e.g., 'Good', 'Attention', 'Critical'
  final double progress; // 0.0 to 1.0

  const DashboardMetric({
    required this.label,
    required this.value,
    this.status = 'Good',
    this.progress = 0.0,
  });

  @override
  List<Object?> get props => [label, value, status, progress];
}
