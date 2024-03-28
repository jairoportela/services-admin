import 'package:flutter/material.dart';
import 'package:services_admin/src/home/presentation/screens/home_screen.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/presentation/screens/service_detail.dart';
import 'package:services_admin/src/services/presentation/screens/service_form_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<void>(
          builder: (_) => const LoadingScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
        );
      case ServiceDetail.routeName:
        final data = settings.arguments as ServiceModel;
        return MaterialPageRoute<void>(
          builder: (_) => ServiceDetail(
            service: data,
          ),
        );
      case ServiceFormScreen.routeName:
        final data = settings.arguments as ServiceFormArguments;
        return MaterialPageRoute<void>(
          builder: (_) => ServiceFormScreen(
            arguments: data,
          ),
        );

      default:
        throw const RouteException('Ruta no encontrada');
    }
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cargando...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  const RouteException(this.message);

  final String message;
}
