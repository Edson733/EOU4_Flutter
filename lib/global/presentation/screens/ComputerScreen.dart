import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/ComputerState.dart';
import '../cubit/ComputerCubit.dart';
import '../../data/models/ManufacturerModel.dart';

class ComputerScreen extends StatefulWidget {
  @override
  _ComputerScreenState createState() => _ComputerScreenState();
}

class _ComputerScreenState extends State<ComputerScreen> {
  ManufacturerModel? selectedManufacturer;

  @override
  void initState() {
    super.initState();
    context.read<ComputerCubit>().fetchAllManufacturers();
    context.read<ComputerCubit>().fetchAllComponentTypes();
    context.read<ComputerCubit>().fetchAllComponents();
    context.read<ComputerCubit>().fetchAllComputers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Computadoras')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ComputerCubit, ComputerState>(
              builder: (context, state) {
                if (state is ManufacturerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ManufacturerError) {
                  return Text('Error: ${state.message}');
                } else if (state is ManufacturerSuccess) {
                  return DropdownButton<ManufacturerModel>(
                    hint: const Text('Selecciona un manufacturador'),
                    value: selectedManufacturer,
                    onChanged: (value) {
                      setState(() {
                        selectedManufacturer = value;
                      });
                    },
                    items: state.manufacturers.map((ManufacturerModel manufacturer) {
                      return DropdownMenuItem<ManufacturerModel>(
                        value: manufacturer,
                        child: Text(manufacturer.name),
                      );
                    }).toList(),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ComputerCubit, ComputerState>(
                      builder: (context, state) {
                        if (state is ComponentTypeLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ComponentTypeError) {
                          return Text('Error: ${state.message}');
                        } else if (state is ComponentTypeSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.componentTypes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(state.componentTypes[index].name),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<ComputerCubit, ComputerState>(
                      builder: (context, state) {
                        if (state is ComponentLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ComponentError) {
                          return Text('Error: ${state.message}');
                        } else if (state is ComponentSuccess) {
                          final manufacturerComponents = selectedManufacturer != null
                              ? state.components.where((component) => component.manufacturer.id == selectedManufacturer!.id,).toList()
                              : state.components;
                          if (manufacturerComponents.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: manufacturerComponents.length,
                              itemBuilder: (context, index) {
                                final component = manufacturerComponents[index];
                                return ListTile(
                                  title: Text('${component.name} - ${component.componentType.name}'),
                                );
                              },
                            );
                          } else {
                            return const Text('No se encontraron componentes de ese manufacturador');
                          }
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<ComputerCubit, ComputerState>(
                      builder: (context, state) {
                        if (state is ComputerSystemLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ComputerSystemError) {
                          return Text('Error: ${state.message}');
                        } else if (state is ComputerSystemSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.computerSystems.length,
                            itemBuilder: (context, index) {
                              final system = state.computerSystems[index];
                              return Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        system.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      const SizedBox(height: 8),
                                      Table(
                                        children: system.components.map((componentEntry) {
                                          final component = componentEntry.component;
                                          return TableRow(children: [
                                            Text('${component.name} - ${component.componentType.name}'),
                                            Text('${componentEntry.quantity} pcs'),
                                          ]);
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}