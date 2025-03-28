class ModelInfoResponse {
  final String model;
  final String description;
  final String image;

  ModelInfoResponse(
      {required this.model, required this.description, required this.image});

  factory ModelInfoResponse.fromJson(Map<String, dynamic> json) =>
      ModelInfoResponse(
        model: json['model'],
        description: json['description'],
        image: json['image'],
      );
}
