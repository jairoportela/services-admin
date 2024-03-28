import 'package:flutter/material.dart';
import 'package:services_admin/src/services/data/models/models.dart';
import 'package:services_admin/src/services/presentation/widgets/status_chip.dart';
import 'package:services_admin/src/utils/extensions/datetime_extension.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
  });

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(16),
        elevation: 2,
      ),
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID: ${service.id}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              StatusChip(
                status: service.status,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Hora del Servicio: ${service.serviceHour.completeDate()}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Ruta: ${service.route}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Cupos Disponibles: ${service.seats}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
