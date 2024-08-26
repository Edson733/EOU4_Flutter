import 'ComponentModel.dart';
import 'ComponentQuantity.dart';

class ComputerSystemModel {
  final int id;
  final String name;
  final List<ComponentQuantity> components;

  ComputerSystemModel({required this.id, required this.name, required this.components});

  factory ComputerSystemModel.fromJson(Map<String, dynamic> json, List<ComponentModel> components) {
    var componentQuantities = (json['components'] as List)
        .map((c) => ComponentQuantity.fromJson(c, components))
        .toList();

    return ComputerSystemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      components: componentQuantities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'components': components.map((c) => c.toJson()).toList(),
    };
  }
}