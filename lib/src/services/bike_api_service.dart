import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/api_models/model_info_response.dart';
import '../models/view_models.dart/bike_model.dart';

/// API Manager
class BikeApiService {
  static const baseUrl = "http://localhost:3000";
  static bool serverAvailable = true;

  static Future<List<dynamic>> fetchData(
      String endpoint, String fallbackPath) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("API Error");
      }
    } catch (_) {
      /// Fallback to Local JSON
      debugPrint('Fallback to Local JSON');
      final fallbackData = await rootBundle.loadString(fallbackPath);
      return json.decode(fallbackData);
    }
  }

  static Future<List<BikeModel>> fetchModels() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate scanning delay

    final data = await fetchData("models", "assets/mock_data/models.json");

    return data
        .map((e) => BikeModel.fromModelInfo(ModelInfoResponse.fromJson(e)))
        .toList();
  }
}
