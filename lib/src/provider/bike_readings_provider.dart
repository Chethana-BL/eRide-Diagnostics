import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/view_models.dart/bike_device.dart';
import '../models/view_models.dart/bike_reading.dart';
import 'bike_connection_provider.dart';

/// Provider for fetching and maintaining bike readings
final bikeReadingsProvider = AsyncNotifierProvider<BikeReadingsNotifier,
    Map<String, BikeReadingViewModel>>(
  BikeReadingsNotifier.new,
);

class BikeReadingsNotifier
    extends AsyncNotifier<Map<String, BikeReadingViewModel>> {
  @override
  Future<Map<String, BikeReadingViewModel>> build() async {
    return {}; // Initial empty state
  }

  Future<void> fetchReadings(BikeDevice bike) async {
    final bikeConnectionService = ref.watch(bikeConnectionProvider);
    state = const AsyncValue.loading(); // Start loading

    try {
      final readings = await bikeConnectionService.fetchReadings(bike);
      state = AsyncValue.data({...state.value ?? {}, bike.deviceId: readings});
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
