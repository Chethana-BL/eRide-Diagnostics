import '../mock_bike/mock_bike.dart';
import 'bike_model.dart';

/// Enum for connection type (BLE or USB)
enum ConnectionType {
  ble,
  usb;

  static ConnectionType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'ble':
        return ConnectionType.ble;
      case 'usb':
        return ConnectionType.usb;
      default:
        throw ArgumentError('Unknown connection type: $value');
    }
  }

  String get displayName {
    switch (this) {
      case ConnectionType.usb:
        return 'USB';
      case ConnectionType.ble:
        return 'BLE';
    }
  }

  String toJson() => name.toLowerCase();
}

class BikeDevice {
  final String deviceId;
  final String deviceName;
  final BikeModelType model;
  final ConnectionType connectionType;
  bool isConnected;

  BikeDevice({
    required this.deviceId,
    required this.deviceName,
    required this.model,
    required this.connectionType,
    this.isConnected = false,
  });

  /// Factory constructor to create `BikeDevice` from a `BikeResponse` object
  factory BikeDevice.fromBike(MockBike bike) {
    return BikeDevice(
      deviceId: bike.id,
      deviceName: bike.name,
      model: BikeModelType.fromString(bike.model),
      connectionType: ConnectionType.fromString(bike.connectionType),
      isConnected: false, // Default to disconnected
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "deviceId": deviceId,
      "deviceName": deviceName,
      "model": model.toJson(),
      "connectionType": connectionType.toJson(),
      "isConnected": isConnected,
    };
  }

  /// Method to update deviceName & connection status
  BikeDevice copyWith({
    String? deviceName,
    bool? isConnected,
  }) {
    return BikeDevice(
      deviceId: deviceId,
      deviceName: deviceName ?? this.deviceName,
      model: model,
      connectionType: connectionType,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
