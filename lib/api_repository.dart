import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/indicator.dart';

class APIService {
  static Future<List<IndicatorModel>> fetchIndicators() async {
    final String response = await rootBundle.loadString('assets/get-indicator-list.json');
    final data = json.decode(response) as List;

    return data.map((json) => IndicatorModel.fromJson(json)).toList();
  }
}
