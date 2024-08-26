class ManufacturerModel {
  final int id;
  final String name;
  final String country;

  ManufacturerModel({required this.id, required this.name, required this.country});

  factory ManufacturerModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerModel(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
    };
  }
}