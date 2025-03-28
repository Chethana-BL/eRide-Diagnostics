import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../models/view_models.dart/bike_device.dart';
import '../models/view_models.dart/bike_model.dart';
import '../models/view_models.dart/bike_reading.dart';
import 'bike_connection_service.dart';

/// Note:
/// This code is a conceptual implementation for BLE and has not been tested and may not function as intended.

class BLEBikeConnectionService implements BikeConnectionService {
  final FlutterReactiveBle _ble = FlutterReactiveBle(); // BLE instance
  late StreamSubscription<DiscoveredDevice> _scanSubscription;
  late StreamSubscription<ConnectionStateUpdate> _connectionSubscription;
  bool _isConnected = false;

  final List<BikeDevice> _discoveredBikes = [];

  // Start scanning for BLE devices
  @override
  Future<List<BikeDevice>> scanForBikes() async {
    // Clear the previous list of devices before starting a new scan
    _discoveredBikes.clear();

    // Start scanning for devices
    _scanSubscription = _ble.scanForDevices(withServices: []).listen(
      (device) {
        // Add discovered device to the list
        final bike = BikeDevice(
          deviceId: device.id,
          deviceName: device.name,
          model: BikeModelType.metroBee,
          connectionType: ConnectionType.ble,
        );
        _discoveredBikes.add(bike);
        debugPrint('Discovered device: ${device.name}');
      },
      onError: (error) {
        debugPrint('Scan failed: $error');
      },
    );

    // Scan duration
    const scanDuration = Duration(seconds: 5);
    Timer(scanDuration, () async {
      await _scanSubscription.cancel(); // Stop the scan after the duration
      debugPrint('Scan completed. Returning discovered devices...');
    });
    await Future.delayed(scanDuration);

    /// Return the list of discovered devices after the [scanDuration]
    return _discoveredBikes;
  }

  // Connect to the discovered BLE device
  @override
  Future<bool> connectToBike(BikeDevice bike) async {
    DiscoveredDevice device = DiscoveredDevice(
      id: bike.deviceId,
      name: bike.deviceName,
      rssi: -50,
      serviceData: {},
      manufacturerData: Uint8List.fromList([0x01, 0x02, 0x03, 0x04, 0x05]),
      serviceUuids: [],
    );

    try {
      // Stop scanning once we find the device
      await _scanSubscription.cancel();

      // Begin connecting to the device
      _connectionSubscription = _ble
          .connectToDevice(
        id: device.id,
        connectionTimeout: Duration(seconds: 10),
      )
          .listen(
        (connectionState) {
          switch (connectionState.connectionState) {
            case DeviceConnectionState.connected:
              _isConnected = true;
              debugPrint('Connected to ${device.name}');
              // After connecting, you can start interacting with the device (e.g., read/write characteristics)
              break;
            case DeviceConnectionState.disconnected:
              _isConnected = false;
              debugPrint('Disconnected from ${device.name}');
              break;
            case DeviceConnectionState.connecting:
              debugPrint('Connecting to ${device.name}...');
              break;
            default:
              debugPrint(
                  'Connection state: ${connectionState.connectionState}');
          }
        },
        onError: (error) {
          debugPrint('Failed to connect: $error');
        },
      );
    } catch (e) {
      debugPrint('Error during connection: $e');
    }

    return true;
  }

  // Disconnect from the BLE device
  @override
  Future<void> disconnectFromBike(BikeDevice bike) async {
    try {
      if (_isConnected) {
        await _connectionSubscription.cancel();
        _isConnected = false;
        debugPrint('Disconnected from device');
      } else {
        debugPrint('No active connection to disconnect.');
      }
    } catch (e) {
      debugPrint('Error during disconnection: $e');
    }
  }

  // Check if the device is connected
  bool get isConnected => _isConnected;

  @override
  Future<BikeReadingViewModel> fetchReadings(BikeDevice bike) {
    // TODO: implement fetchReadings
    throw UnimplementedError();
  }
}
