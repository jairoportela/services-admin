import 'package:flutter/material.dart';

class ServiceSubmitButton extends StatelessWidget {
  const ServiceSubmitButton({
    super.key,
    required this.isNewService,
  });

  final bool isNewService;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: Text(
        isNewService ? 'Crear' : 'Editar',
      ),
    );
  }
}
