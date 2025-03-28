import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/bike_connection_service.dart';
import '../services/mock_bike_connection_service.dart';
import '../services/ble_bike_connection_service.dart';

final bikeConnectionProvider = Provider<BikeConnectionService>((ref) {
  const bool useMock = true; // Toggle to switch between real & mock
  return useMock ? MockBikeConnectionService() : BLEBikeConnectionService();
});
