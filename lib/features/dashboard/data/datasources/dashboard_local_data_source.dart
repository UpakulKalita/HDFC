import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/dashboard/data/models/dashboard_metric_model.dart';
import 'package:insurance_flutter/features/dashboard/data/models/recommendation_model.dart';

abstract class DashboardLocalDataSource {
  Future<List<DashboardMetricModel>> getProtectionScoreMetrics();
  Future<List<RecommendationModel>> getRecommendations();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  @override
  Future<List<DashboardMetricModel>> getProtectionScoreMetrics() async {
    // Mock data simulation (Reduced delay for snappier UI)
    await Future.delayed(const Duration(milliseconds: 30));
    return const [
      DashboardMetricModel(
        label: 'Life', 
        value: 'Underinsured', 
        status: 'Critical', 
        progress: 0.5,
      ),
      DashboardMetricModel(
        label: 'Term Life', 
        value: 'Adequate',
        status: 'Good', 
        progress: 0.94,
      ),
    ];
  }

  @override
  Future<List<RecommendationModel>> getRecommendations() async {
    // Mock data simulation (Reduced delay for snappier UI)
    await Future.delayed(const Duration(milliseconds: 50));

    return [
      RecommendationModel(
        id: '1',
        type: 'Health',
        typeColor: const Color(0xFF4CAF50),
        title: 'Smart Health Plus',
        price: '₹2,499/mo',
        coverage: '₹5 Lakhs',
        claimRatio: '98.5%',
        waitingPeriod: '2 Yrs',
        features: [
          'Covers 100% of hospitalization expenses.',
          'Includes dental and vision care treatments.',
          'Full support for mental well-being.',
          'Access to doctors 24/7 anytime.',
        ],
        tags: ['Tax Saver', 'No Medical Test'],
        imageUrl: 'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&q=80&w=600',
      ),
      RecommendationModel(
        id: '2',
        type: 'Term Life',
        typeColor: Colors.blue,
        title: 'Superior Life Plan',
        price: '₹1,899/mo',
        coverage: '₹1 Crore',
        claimRatio: '99.1%',
        waitingPeriod: 'Nil',
        features: [
          'High-value term life insurance with critical rider.',
          'Lump sum payout on terminal illness.',
          'Tax benefits under Section 80C.',
          'Flexible premium payment terms.',
        ],
        tags: ['Best Seller', 'High Cover'],
        imageUrl: 'https://images.unsplash.com/photo-1576091160550-217359f488d5?auto=format&fit=crop&q=80&w=600',
      ),
      RecommendationModel(
        id: '3',
        type: 'Health',
        typeColor: const Color(0xFF4CAF50),
        title: 'Critical Care Plus',
        price: '₹2,999/mo',
        coverage: '₹10 Lakhs',
        claimRatio: '98.8%',
        waitingPeriod: '1 Yr',
        features: [
          'Advanced protection for critical illnesses.',
          'Covers 32 major critical illnesses.',
          'Cashless treatment at 10k+ hospitals.',
          'Alternative medicine (AYUSH) cover.',
        ],
        tags: ['Comprehensive', 'Critical Care'],
        imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=600',
      ),
    ];
  }
}
