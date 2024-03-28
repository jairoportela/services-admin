import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/config/router.dart';
import 'package:services_admin/src/home/presentation/screens/home_screen.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';
import 'package:services_admin/src/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ServicesApp extends StatelessWidget {
  const ServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceRepository repo = ServiceRepositoryImplementation();
    return RepositoryProvider.value(
      value: repo,
      child: const AppView(),
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
        Future.delayed(const Duration(seconds: 1)).then((value) {
          _navigator.pushNamedAndRemoveUntil<void>(
            HomeScreen.routeName,
            (route) => false,
          );
        });

        return child ?? const SizedBox();
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
