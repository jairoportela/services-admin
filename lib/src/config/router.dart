import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<void>(
          builder: (_) => const LoadingScreen(),
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
