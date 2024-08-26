class ComponentTypeModel {
  final int id;
  final String name;

  ComponentTypeModel({required this.id, required this.name});

  factory ComponentTypeModel.fromJson(Map<String, dynamic> json) {
    return ComponentTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}