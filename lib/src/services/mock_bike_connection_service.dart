import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/mock_bike/mock_bike_reading.dart';
import '../models/mock_bike/mock_bike.dart';
import '../models/view_models.dart/bike_device.dart';
import '../models/view_models.dart/bike_reading.dart';
import 'bike_connection_service.dart';

class MockBikeConnectionService implements BikeConnectionService {
  @override
  Future<List<BikeDevice>> scanForBikes() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate scanning delay

    final jsonStr = await rootBundle.loadString('assets/mock_data/bikes.json');
    final data = json.decode(jsonStr) as List;

    return data.map((e) => BikeDevice.fromBike(MockBike.fromJson(e))).toList();
  }

  @override
  Future<bool> connectToBike(BikeDevice bike) async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate scanning delay
    bike.copyWith(isConnected: true);
    return true;
  }

  @override
  Future<BikeReadingViewModel> fetchReadings(BikeDevice bike) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate scanning delay

    final jsonStr =
        await rootBundle.loadString('assets/mock_data/readings.json');
    final data = json.decode(jsonStr) as List;
    final bikeReadings = data.firstWhere(
        (entry) => entry['bikeId'] == bike.deviceId,
        orElse: () => []);

    if (bikeReadings.isNotEmpty) {
      return BikeReadingViewModel.fromResponse(
          MockBikeReading.fromJson(bikeReadings));
    } else {
      debugPrint('Bike Id: ${bike.deviceId} readings were not found');
      throw ('Bike Id: ${bike.deviceId} readings were not found');
    }
  }

  @override
  Future<void> disconnectFromBike(BikeDevice bike) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate scanning delay
    bike.copyWith(isConnected: false);
    return;
  }
}
