import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';
import 'package:go_router/go_router.dart';

class TransisiApp extends StatelessWidget {
  final BaseApiClient apiClient;
  final BaseCacheClient cacheClient;
  final BaseAuthenticationRepository authRepository;
  final BaseEmployeeRepository employeeRepository;

  const TransisiApp({
    super.key,
    required this.apiClient,
    required this.cacheClient,
    required this.authRepository,
    required this.employeeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BaseApiClient>.value(value: apiClient),
        RepositoryProvider<BaseCacheClient>.value(value: cacheClient),
        RepositoryProvider<BaseAuthenticationRepository>.value(
          value: authRepository,
        ),
        RepositoryProvider<BaseEmployeeRepository>.value(
          value: employeeRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationDataCubit>(
            create: (_) =>
                AuthenticationDataCubit(authRepository: authRepository)
                  ..initialize(),
          ),
          BlocProvider<AuthenticationActionCubit>(
            create: (_) =>
                AuthenticationActionCubit(authRepository: authRepository),
          ),
        ],
        child: _AppView(),
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(context.read<AuthenticationDataCubit>());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EmployeeListCubit(
            employeeRepository: context.read<BaseEmployeeRepository>(),
          )..fetchEmployees(),
        ),
        BlocProvider(create: (_) => EmployeeDetailCubit()),
        BlocProvider<CreateEmployeeCubit>(
          create: (_) => CreateEmployeeCubit(
            employeeRepository: context.read<BaseEmployeeRepository>(),
          ),
        ),
        BlocProvider<EditEmployeeCubit>(
          create: (_) => EditEmployeeCubit(
            employeeRepository: context.read<BaseEmployeeRepository>(),
          ),
        ),
        BlocProvider<DeleteEmployeeCubit>(
          create: (_) => DeleteEmployeeCubit(
            employeeRepository: context.read<BaseEmployeeRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Employee Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        ),
        routerConfig: _router,
        builder: (context, child) {
          return BlocListener<AuthenticationActionCubit, BaseState>(
            listener: (context, state) {
              if (state is SuccessState) {
                context.read<AuthenticationDataCubit>().initialize();
              }
            },
            child: child!,
          );
        },
      ),
    );
  }
}
