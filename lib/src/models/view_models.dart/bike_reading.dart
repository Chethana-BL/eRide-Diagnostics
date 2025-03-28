import '../mock_bike/mock_bike_reading.dart';

class BikeReadingViewModel {
  final String bikeId;
  final String batteryCharge;
  final String odoMeter;
  final String lastError;
  final String lastAntiTheft;
  final String motorRPM;
  final String totalAirtime;
  final String gyroscope;

  BikeReadingViewModel({
    required this.bikeId,
    required this.batteryCharge,
    required this.odoMeter,
    required this.lastError,
    required this.lastAntiTheft,
    required this.motorRPM,
    required this.totalAirtime,
    required this.gyroscope,
  });

  /// Mapping function from API response to ViewModel
  factory BikeReadingViewModel.fromResponse(MockBikeReading response) {
    return BikeReadingViewModel(
      bikeId: response.bikeId,
      batteryCharge: response.batteryCharge,
      odoMeter: response.odoMeter,
      lastError: response.lastError,
      lastAntiTheft: response.lastAntiTheft,
      motorRPM: response.motorRPM,
      totalAirtime: response.totalAirtime,
      gyroscope: response.gyroscope != null
          ? 'x: ${response.gyroscope!['x']}, y: ${response.gyroscope!['y']}, z: ${response.gyroscope!['z']}'
          : '-',
    );
  }
}
