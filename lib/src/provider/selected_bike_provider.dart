import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/view_models.dart/bike_device.dart';

final selectedBikeProvider = StateProvider<BikeDevice?>((ref) => null);
