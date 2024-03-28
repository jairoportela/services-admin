import 'package:flutter/material.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';

class NotAuthScreen extends StatelessWidget {
  const NotAuthScreen({super.key});
  static const routeName = '/not-auth';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              color: Colors.amber,
              size: 150,
            ),
            SizedBox(height: 10),
            TitleText('No tiene acceso al dashboard.'),
          ],
        ),
      ),
    );
  }
}
