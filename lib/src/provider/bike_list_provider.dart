import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/view_models.dart/bike_device.dart';
import 'bike_connection_provider.dart';
import 'selected_bike_provider.dart';

/// Provider for fetching & maintaining scanned bikes list
final bikeListProvider =
    AsyncNotifierProvider<BikeListNotifier, List<BikeDevice>>(
        BikeListNotifier.new);

class BikeListNotifier extends AsyncNotifier<List<BikeDevice>> {
  @override
  Future<List<BikeDevice>> build() async {
    return []; // Initial empty state
  }

  /// Scans for bikes & updates state
  Future<void> scanBikes() async {
    final bikeConnectionService = ref.watch(bikeConnectionProvider);

    /// Reset selected bike
    ref.read(selectedBikeProvider.notifier).state = null;

    state = const AsyncValue.loading(); // Start loading

    try {
      final bikes = await bikeConnectionService.scanForBikes();
      state = AsyncValue.data(bikes);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void updateBikeConnection(String bikeId, bool isConnected) {
    state = state.whenData((bikes) {
      return bikes.map((bike) {
        if (bike.deviceId == bikeId) {
          return bike.copyWith(isConnected: isConnected);
        }
        return bike;
      }).toList();
    });
  }
}
