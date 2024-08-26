import 'package:bloc/bloc.dart';
import 'ComputerState.dart';
import '../../data/repository/ComputerRepository.dart';
import '../../data/models/ManufacturerModel.dart';
import '../../data/models/ComponentTypeModel.dart';
import '../../data/models/ComponentModel.dart';
import '../../data/models/ComputerSystemModel.dart';

class ComputerCubit extends Cubit<ComputerState> {
  final ComputerRepository computerRepository;

  ComputerCubit({required this.computerRepository}) : super(ComputerSystemInitial());

  Future<void> fetchAllComputers() async {
    try {
      emit(ComputerSystemLoading());
      final data = await computerRepository.getAllData();
      final computerSystems = data['computer_systems'] as List<ComputerSystemModel>;
      emit(ComputerSystemSuccess(computerSystems));
    } catch (e) {
      emit(ComputerSystemError(e.toString()));
    }
  }

  Future<void> fetchAllManufacturers() async {
    try {
      emit(ManufacturerLoading());
      final data = await computerRepository.getAllData();
      final manufacturers = data['manufacturers'] as List<ManufacturerModel>;
      emit(ManufacturerSuccess(manufacturers));
    } catch (e) {
      emit(ManufacturerError(e.toString()));
    }
  }

  Future<void> fetchAllComponentTypes() async {
    try {
      emit(ComponentTypeLoading());
      final data = await computerRepository.getAllData();
      final componentTypes = data['component_types'] as List<ComponentTypeModel>;
      emit(ComponentTypeSuccess(componentTypes));
    } catch (e) {
      emit(ComponentTypeError(e.toString()));
    }
  }

  Future<void> fetchAllComponents() async {
    try {
      emit(ComponentLoading());
      final data = await computerRepository.getAllData();
      final components = data['components'] as List<ComponentModel>;
      emit(ComponentSuccess(components));
    } catch (e) {
      emit(ComponentError(e.toString()));
    }
  }
}