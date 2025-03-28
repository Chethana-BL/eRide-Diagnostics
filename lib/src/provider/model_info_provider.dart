import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/view_models.dart/bike_model.dart';
import '../services/bike_api_service.dart';

/// Provider for fetching and maintaining model info
final modelInfoProvider =
    AsyncNotifierProvider<ModelInfoNotifier, Map<BikeModelType, BikeModel>>(
  ModelInfoNotifier.new,
);

class ModelInfoNotifier extends AsyncNotifier<Map<BikeModelType, BikeModel>> {
  @override
  Future<Map<BikeModelType, BikeModel>> build() async {
    return {}; // Initial empty state
  }

  Future<void> fetchModelInfo() async {
    state = const AsyncValue.loading(); // Start loading
    try {
      final models = await BikeApiService.fetchModels();
      final modelMap = {for (var m in models) m.model: m};
      state = AsyncValue.data(modelMap);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
