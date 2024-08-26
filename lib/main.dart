import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'global/presentation/screens/ComputerScreen.dart';
import 'global/presentation/cubit/ComputerCubit.dart';
import 'global/data/repository/ComputerRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ComputerRepository>(
            create: (context) => ComputerRepository(
              apiURL: 'https://noeaywzny9.execute-api.us-east-1.amazonaws.com/Stage/hello'
            )
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ComputerCubit>(
              create: (context) => ComputerCubit(
                computerRepository: RepositoryProvider.of<ComputerRepository>(context)
              )
            )
          ],
          child: MaterialApp(
            title: 'Computer Components',
            debugShowCheckedModeBanner: false,
            home: ComputerScreen()
          )
        )
    );
  }
}
