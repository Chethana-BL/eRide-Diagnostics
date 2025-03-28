class MockBike {
  final String id;
  final String name;
  final String connectionType;
  final String model;

  MockBike({
    required this.id,
    required this.name,
    required this.connectionType,
    required this.model,
  });

  factory MockBike.fromJson(Map<String, dynamic> json) => MockBike(
        id: json['id'],
        name: json['name'],
        connectionType: json['connectionType'],
        model: json['model'],
      );
}
