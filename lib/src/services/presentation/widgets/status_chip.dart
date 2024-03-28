import 'package:flutter/material.dart';
import 'package:services_admin/src/services/data/models/models.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
  });
  final ServiceStatus status;

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide.none,
      label: Text(
        status.title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: status.color,
    );
  }
}
