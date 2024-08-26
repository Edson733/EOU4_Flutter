import 'ComponentTypeModel.dart';
import 'ManufacturerModel.dart';

class ComponentModel {
  final int id;
  final String name;
  final ManufacturerModel manufacturer;
  final ComponentTypeModel componentType;

  ComponentModel({required this.id, required this.name, required this.manufacturer, required this.componentType});

  factory ComponentModel.fromJson(Map<String, dynamic> json, List<ManufacturerModel> manufacturers, List<ComponentTypeModel> componentTypes) {
    return ComponentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      manufacturer: manufacturers.firstWhere((m) => m.id == json['manufacturer_id']),
      componentType: componentTypes.firstWhere((ct) => ct.id == json['component_type_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer.toJson(),
      'componentType': componentType.toJson(),
    };
  }
}