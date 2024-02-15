import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testik/source/presentation/bloc/employer_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void loadUsers() {
    context.read<EmployerBloc>().add(const LoadEmployersApi());
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerBloc, EmployerState>(
      builder: (context, state) {
        return state is LoadingEmployers
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text("Kto"),
                ),
                backgroundColor: Colors.white,
              );
      },
    );
  }
}
