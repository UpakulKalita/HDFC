class CoverageData {
  final double currentCoverage;
  final double targetCoverage;
  final String status;
  final String statusMessage;
  final String recommendation;
  final double coveragePercentage;

  CoverageData({
    required this.currentCoverage,
    required this.targetCoverage,
    required this.status,
    required this.statusMessage,
    required this.recommendation,
    required this.coveragePercentage,
  });
}

final mockCoverageData = CoverageData(
  currentCoverage: 2700000,
  targetCoverage: 4000000,
  status: 'Underinsured',
  statusMessage: 'Coverage is clearly insufficient. User is exposed to financial risk.',
  recommendation: 'Strong advisory required.',
  coveragePercentage: 0.67,
);
