import '../api_models/model_info_response.dart';

/// Enum for bike models
enum BikeModelType {
  metroBee,
  cliffHanger;

  static BikeModelType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'metrobee':
        return BikeModelType.metroBee;
      case 'cliffhanger':
        return BikeModelType.cliffHanger;
      default:
        throw ArgumentError('Unknown bike model: $value');
    }
  }

  String get displayName {
    switch (this) {
      case BikeModelType.metroBee:
        return 'Metro Bee';
      case BikeModelType.cliffHanger:
        return 'Cliff Hanger';
    }
  }

  String toJson() => name.toLowerCase();
}

/// Model Info
class BikeModel {
  final BikeModelType model;
  final String description;
  final String image;

  BikeModel({
    required this.model,
    required this.description,
    required this.image,
  });

  /// Factory method to convert from JSON model class (`ModelInfo`)
  factory BikeModel.fromModelInfo(ModelInfoResponse modelInfo) {
    return BikeModel(
      model: BikeModelType.fromString(modelInfo.model),
      description: modelInfo.description,
      image: modelInfo.image,
    );
  }
}
