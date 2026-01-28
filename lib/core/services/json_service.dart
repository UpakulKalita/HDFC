import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:insurance_flutter/features/dashboard/data/models/insurance_plan_model.dart';

class JsonService {
  static Future<List<HealthPlan>> loadHealthPlans() async {
    final String response = await rootBundle.loadString('assets/data/health_plans.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => HealthPlan.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<List<AutoPlan>> loadAutoPlans() async {
    final String response = await rootBundle.loadString('assets/data/auto_plans.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => AutoPlan.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<List<TermPlan>> loadTermPlans() async {
    final String response = await rootBundle.loadString('assets/data/term_plans.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => TermPlan.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<PlanDetail?> loadPlanDetail(String title) async {
    final String response = await rootBundle.loadString('assets/data/plan_details.json');
    final Map<String, dynamic> data = await json.decode(response) as Map<String, dynamic>;
    if (data.containsKey(title)) {
      return PlanDetail.fromJson(data[title] as Map<String, dynamic>);
    }
    return null;
  }
}
