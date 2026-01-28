import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Recommendation extends Equatable {
  final String id;
  final String type; // 'Health', 'Term Life', etc.
  final Color typeColor; // Domain entities usually shouldn't depend on UI (Color), but for this rapid refactor we'll keep it simple. Ideally this maps to an enum.
  final String title;
  final String price;
  final String coverage;
  final String claimRatio;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final String imageUrl;

  const Recommendation({
    required this.id,
    required this.type,
    required this.typeColor,
    required this.title,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        typeColor,
        title,
        price,
        coverage,
        claimRatio,
        waitingPeriod,
        features,
        tags,
        imageUrl,
      ];
}
