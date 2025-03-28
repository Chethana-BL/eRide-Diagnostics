import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/view_models.dart/bike_device.dart';
import '../utils/analytics_logger.dart';
import 'bike_connection_provider.dart';
import 'bike_list_provider.dart';
import 'selected_bike_provider.dart';

/// Provider for maintaining bike connection state
final bikeConnectionStateProvider =
    StateNotifierProvider<BikeConnectionNotifier, void>(
  BikeConnectionNotifier.new,
);

class BikeConnectionNotifier extends StateNotifier<void> {
  BikeConnectionNotifier(this.ref) : super({});

  final Ref ref;

  /// Connects or disconnects a bike
  Future<void> toggleBikeConnection(BikeDevice bike) async {
    final bikeConnectionService = ref.watch(bikeConnectionProvider);
    final isCurrentlyConnected = bike.isConnected;
    final newConnectionState = !isCurrentlyConnected;

    try {
      if (newConnectionState) {
        await bikeConnectionService.connectToBike(bike);
        AnalyticsLogger.logEvent(
          AnalyticsEvent.bikeConnected,
          bikeId: bike.deviceId,
        );
      } else {
        await bikeConnectionService.disconnectFromBike(bike);
        AnalyticsLogger.logEvent(
          AnalyticsEvent.bikeDisconnected,
          bikeId: bike.deviceId,
        );
      }

      // Update selected bike state
      ref.read(selectedBikeProvider.notifier).state =
          bike.copyWith(isConnected: newConnectionState);

      // Update bike list state
      ref
          .read(bikeListProvider.notifier)
          .updateBikeConnection(bike.deviceId, newConnectionState);
    } catch (e) {
      debugPrint("Connection error: $e");
      AnalyticsLogger.logEvent(
        AnalyticsEvent.errorOccurred,
        bikeId: bike.deviceId,
        errorMessage: 'Connection error: $e',
      );
    }
  }
}
