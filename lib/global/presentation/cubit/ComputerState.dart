import 'package:equatable/equatable.dart';
import '../../data/models/ManufacturerModel.dart';
import '../../data/models/ComponentTypeModel.dart';
import '../../data/models/ComponentModel.dart';
import '../../data/models/ComputerSystemModel.dart';

abstract class ComputerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManufacturerInitial extends ComputerState {}

class ManufacturerLoading extends ComputerState {}

class ManufacturerSuccess extends ComputerState {
  final List<ManufacturerModel> manufacturers;
  ManufacturerSuccess(this.manufacturers);

  @override
  List<Object?> get props => [manufacturers];
}

class ManufacturerError extends ComputerState {
  final String message;
  ManufacturerError(this.message);

  @override
  List<Object?> get props => [message];
}

class ComponentTypeInitial extends ComputerState {}

class ComponentTypeLoading extends ComputerState {}

class ComponentTypeSuccess extends ComputerState {
  final List<ComponentTypeModel> componentTypes;
  ComponentTypeSuccess(this.componentTypes);

  @override
  List<Object?> get props => [componentTypes];
}

class ComponentTypeError extends ComputerState {
  final String message;
  ComponentTypeError(this.message);

  @override
  List<Object?> get props => [message];
}

class ComponentInitial extends ComputerState {}

class ComponentLoading extends ComputerState {}

class ComponentSuccess extends ComputerState {
  final List<ComponentModel> components;
  ComponentSuccess(this.components);

  @override
  List<Object?> get props => [components];
}

class ComponentError extends ComputerState {
  final String message;
  ComponentError(this.message);

  @override
  List<Object?> get props => [message];
}

class ComputerSystemInitial extends ComputerState {}

class ComputerSystemLoading extends ComputerState {}

class ComputerSystemSuccess extends ComputerState {
  final List<ComputerSystemModel> computerSystems;
  ComputerSystemSuccess(this.computerSystems);

  @override
  List<Object?> get props => [computerSystems];
}

class ComputerSystemError extends ComputerState {
  final String message;
  ComputerSystemError(this.message);

  @override
  List<Object?> get props => [message];
}