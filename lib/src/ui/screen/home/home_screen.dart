import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListCubit, BaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Employees',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () async {
                  await context.read<AuthenticationActionCubit>().logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
              ),
            ],
          ),
          body: () {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorState) {
              return ErrorView(
                message: state.error,
                onRetry: () =>
                    context.read<EmployeeListCubit>().fetchEmployees(),
              );
            }

            if (state is EmptyState) {
              return const EmptyView(
                message: 'No employees found.\nTap + to add one.',
              );
            }

            if (state is LoadedState) {
              final employees = state.data as List<Employee>;
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<EmployeeListCubit>().fetchEmployees(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return EmployeeListTile(
                      employee: employee,
                      onTap: () {
                        context.read<EmployeeDetailCubit>().select(employee);
                        context.go('/detail');
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          }(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/add'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
