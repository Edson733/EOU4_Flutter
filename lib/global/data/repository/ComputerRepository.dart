import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ManufacturerModel.dart';
import '../models/ComponentTypeModel.dart';
import '../models/ComponentModel.dart';
import '../models/ComputerSystemModel.dart';

class ComputerRepository {
  final String apiURL;

  ComputerRepository({required this.apiURL});

  Future<Map<String, List<dynamic>>> getAllData() async {
    final response = await http.get(
      Uri.parse(apiURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<ManufacturerModel> manufacturers = List<ManufacturerModel>
          .from(data['manufacturers'].map((model) => ManufacturerModel.fromJson(model)));
      List<ComponentTypeModel> componentTypes = List<ComponentTypeModel>
          .from(data['component_types'].map((model) => ComponentTypeModel.fromJson(model)));
      List<ComponentModel> components = List<ComponentModel>
          .from(data['components'].map((model) => ComponentModel.fromJson(model, manufacturers, componentTypes)));
      List<ComputerSystemModel> computerSystems = List<ComputerSystemModel>
          .from(data['computer_systems'].map((model) => ComputerSystemModel.fromJson(model, components)));
      return {
        'manufacturers': manufacturers,
        'component_types': componentTypes,
        'components': components,
        'computer_systems': computerSystems
      };
    } else {
      throw Exception('Ocurrió un error al obtener los datos');
    }
  }
}