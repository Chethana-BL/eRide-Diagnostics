class MockBikeReading {
  final String bikeId;
  final String batteryCharge;
  final String odoMeter;
  final String lastError;
  final String lastAntiTheft;
  final String motorRPM;
  final String totalAirtime;
  final Map<String, dynamic>? gyroscope;

  MockBikeReading({
    required this.bikeId,
    required this.batteryCharge,
    required this.odoMeter,
    required this.lastError,
    required this.lastAntiTheft,
    required this.motorRPM,
    required this.totalAirtime,
    required this.gyroscope,
  });

  factory MockBikeReading.fromJson(Map<String, dynamic> json) =>
      MockBikeReading(
        bikeId: json['bikeId'],
        batteryCharge: json['batteryCharge'] ?? '-',
        odoMeter: json['odoMeter'] ?? '-',
        lastError: json['lastError'] ?? '-',
        lastAntiTheft: json['lastAntiTheft'] ?? '-',
        motorRPM: json['motorRPM'] ?? '-',
        totalAirtime: json['totalAirtime'] ?? '-',
        gyroscope: json['gyroscope'],
      );
}
