import 'package:flutter/material.dart';
import 'package:services_admin/src/config/router.dart';
import 'package:services_admin/src/home/presentation/screens/home_screen.dart';
import 'package:services_admin/src/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ServicesApp extends StatelessWidget {
  const ServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
