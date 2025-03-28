import '../models/view_models.dart/bike_device.dart';
import '../models/view_models.dart/bike_reading.dart';

abstract class BikeConnectionService {
  Future<List<BikeDevice>> scanForBikes();
  Future<bool> connectToBike(BikeDevice bike);
  Future<BikeReadingViewModel> fetchReadings(BikeDevice bike);
  Future<void> disconnectFromBike(BikeDevice bike);
}
