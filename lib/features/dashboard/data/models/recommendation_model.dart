

import 'package:insurance_flutter/features/dashboard/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    required super.id,
    required super.type,
    required super.typeColor, // In a real app, this would be mapped from a string/enum
    required super.title,
    required super.price,
    required super.coverage,
    required super.claimRatio,
    required super.waitingPeriod,
    required super.features,
    required super.tags,
    required super.imageUrl,
  });

  // For now, we are skipping complex JSON parsing for Color as we are using mock data directly
  // In a real scenario, we'd map a string color code or enum to a Color object.
}
