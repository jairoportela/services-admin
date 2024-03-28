import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/authentication/data/repository/authentication_repository.dart';
import 'package:services_admin/src/authentication/providers/app_bloc/app_bloc.dart';
import 'package:services_admin/src/config/router.dart';
import 'package:services_admin/src/home/presentation/screens/home_screen.dart';
import 'package:services_admin/src/home/presentation/screens/not_auth_screen.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';
import 'package:services_admin/src/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ServicesApp extends StatelessWidget {
  const ServicesApp({super.key, required this.authenticationRepository});
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    final ServiceRepository repo = ServiceRepositoryImplementation();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: repo,
        ),
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) =>
            AppBloc(authenticationRepository: authenticationRepository)
              ..add(AppUserChanged()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Services Admin',
      theme: AppTheme.theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'CO'),
        Locale('es', 'MX'),
      ],
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            log(state.toString());
            switch (state.status) {
              case AppStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  HomeScreen.routeName,
                  (route) => false,
                );
              case AppStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  NotAuthScreen.routeName,
                  (route) => false,
                );
              default:
                _navigator.pushNamedAndRemoveUntil<void>(
                  '/',
                  (route) => false,
                );
            }
          },
          child: child,
        );
      },
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
