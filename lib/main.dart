import 'package:bloc_ex/bloc/employee_bloc.dart';
import 'package:bloc_ex/cubit/counter_cubit.dart';
import 'package:bloc_ex/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CounterCubit(),
      ),
      BlocProvider(
        create: (context) => EmployeeBloc(EmployeeRepository()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(EmployeeAddedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EmployeeLoadedState) {
            return ListView.builder(
                itemCount: state.employee.length,
                itemBuilder: (context, index) => ListTile(
                      title:
                          Text(state.employee[index].name?.first ?? "No Name"),
                      subtitle: Text(state.employee[index].email ?? "No Email"),
                    ));
          } else if (state is EmployeeErrorState) {
            return Text('Employees : ${state.errorMessage}');
          } else {
            return const Text('No state');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
