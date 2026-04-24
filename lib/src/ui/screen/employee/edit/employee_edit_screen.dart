import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';
import 'package:go_router/go_router.dart';

class EmployeeEditScreen extends StatefulWidget {
  const EmployeeEditScreen({super.key});

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _websiteController;
  late final TextEditingController _companyController;
  late final String _employeeId;

  @override
  void initState() {
    super.initState();
    final state = context.read<EmployeeDetailCubit>().state;
    final employee = state is LoadedState
        ? state.data as Employee
        : const Employee(
            id: '',
            data: EmployeeData(
              firstName: '',
              lastName: '',
              email: '',
              phone: '',
              website: '',
              companyName: '',
            ),
          );

    _employeeId = employee.id;
    _firstNameController = TextEditingController(text: employee.data.firstName);
    _lastNameController = TextEditingController(text: employee.data.lastName);
    _emailController = TextEditingController(text: employee.data.email);
    _phoneController = TextEditingController(text: employee.data.phone);
    _websiteController = TextEditingController(text: employee.data.website);
    _companyController = TextEditingController(text: employee.data.companyName);
  }

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

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditEmployeeCubit>().editEmployee(
            _employeeId,
            Employee(
              id: _employeeId,
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
    return BlocListener<EditEmployeeCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          final updated = state.data as Employee;
          context.read<EmployeeDetailCubit>().select(updated);
          context.read<EmployeeListCubit>().fetchEmployees();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Employee updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          context.go('/detail');
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
          title: const Text('Edit Employee'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/detail'),
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
                  'Edit Employee Information',
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
                BlocBuilder<EditEmployeeCubit, BaseState>(
                  builder: (context, state) {
                    return LoadingButton(
                      label: 'Save Changes',
                      isLoading: state is LoadingState,
                      onPressed: _submit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
