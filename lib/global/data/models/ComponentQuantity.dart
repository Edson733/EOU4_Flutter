import 'ComponentModel.dart';

class ComponentQuantity {
  final ComponentModel component;
  final int quantity;

  ComponentQuantity({required this.component, required this.quantity});

  factory ComponentQuantity.fromJson(Map<String, dynamic> json, List<ComponentModel> components) {
    return ComponentQuantity(
      component: components.firstWhere((c) => c.id == json['component_id']),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'quantity': quantity,
    };
  }
}