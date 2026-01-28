class InsurancePlan {
  final String title;
  final String imageUrl;
  final String price;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  InsurancePlan({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.features,
    required this.tags,
    required this.isPopular,
  });

  factory InsurancePlan.fromJson(Map<String, dynamic> json) {
    return InsurancePlan(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      features: (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool,
    );
  }
}

class HealthPlan extends InsurancePlan {
  final String coverage;
  final String claimRatio;
  final String hospitals;
  final String waitingPeriod;

  HealthPlan({
    required super.title,
    required super.imageUrl,
    required super.price,
    required super.features,
    required super.tags,
    required super.isPopular,
    required this.coverage,
    required this.claimRatio,
    required this.hospitals,
    required this.waitingPeriod,
  });

  factory HealthPlan.fromJson(Map<String, dynamic> json) {
    return HealthPlan(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      features: (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool,
      coverage: json['coverage'] as String,
      claimRatio: json['claimRatio'] as String,
      hospitals: json['hospitals'] as String,
      waitingPeriod: json['waitingPeriod'] as String,
    );
  }
}

class AutoPlan extends InsurancePlan {
  final String idv;
  final String ncb;
  final String garages;

  AutoPlan({
    required super.title,
    required super.imageUrl,
    required super.price,
    required super.features,
    required super.tags,
    required super.isPopular,
    required this.idv,
    required this.ncb,
    required this.garages,
  });

  factory AutoPlan.fromJson(Map<String, dynamic> json) {
    return AutoPlan(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      features: (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool,
      idv: json['idv'] as String,
      ncb: json['ncb'] as String,
      garages: json['garages'] as String,
    );
  }
}

class TermPlan extends InsurancePlan {
  final String coverage;
  final String claimRatio;
  final String term;
  final String waitingPeriod;

  TermPlan({
    required super.title,
    required super.imageUrl,
    required super.price,
    required super.features,
    required super.tags,
    required super.isPopular,
    required this.coverage,
    required this.claimRatio,
    required this.term,
    required this.waitingPeriod,
  });

  factory TermPlan.fromJson(Map<String, dynamic> json) {
    return TermPlan(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      features: (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool,
      coverage: json['coverage'] as String,
      claimRatio: json['claimRatio'] as String,
      term: json['term'] as String,
      waitingPeriod: json['waitingPeriod'] as String,
    );
  }
}

class PlanDetail {
  final String description;
  final List<String> benefits;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<Map<String, String>> faqs;

  PlanDetail({
    required this.description,
    required this.benefits,
    required this.inclusions,
    required this.exclusions,
    required this.faqs,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> json) {
    return PlanDetail(
      description: json['description'] as String,
      benefits: (json['benefits'] as List<dynamic>).map((e) => e as String).toList(),
      inclusions: (json['inclusions'] as List<dynamic>).map((e) => e as String).toList(),
      exclusions: (json['exclusions'] as List<dynamic>).map((e) => e as String).toList(),
      faqs: (json['faqs'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)))
          .toList(),
    );
  }
}
