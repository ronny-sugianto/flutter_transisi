import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';
import 'package:go_router/go_router.dart';

class EmployeeAddScreen extends StatefulWidget {
  const EmployeeAddScreen({super.key});

  @override
  State<EmployeeAddScreen> createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CreateEmployeeCubit>().createEmployee(
        Employee(
          id: '',
          data: EmployeeData(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            website: _websiteController.text.trim(),
            companyName: _companyController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CreateEmployeeCubit>(),
      child: BlocListener<CreateEmployeeCubit, BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Employee created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            context.pop();
            context.read<EmployeeListCubit>().fetchEmployees();
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Employee Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'First Name',
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    validator: (v) => AppValidator.required(v, 'First name'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Last Name',
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    validator: (v) => AppValidator.required(v, 'Last name'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: AppValidator.email,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (v) => AppValidator.required(v, 'Phone'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Website',
                    controller: _websiteController,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Company Name',
                    controller: _companyController,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<CreateEmployeeCubit, BaseState>(
                    builder: (context, state) {
                      return LoadingButton(
                        label: 'Create Employee',
                        isLoading: state is LoadingState,
                        onPressed: () => _submit(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
