import 'package:flutter/material.dart';
import 'package:services_admin/src/home/presentation/widgets/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      body: const HomeView(),
    );
  }
}
