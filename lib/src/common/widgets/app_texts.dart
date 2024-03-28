import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
    );
  }
}
