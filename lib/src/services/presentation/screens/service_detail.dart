import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/presentation/screens/service_form_screen.dart';
import 'package:services_admin/src/services/presentation/widgets/status_chip.dart';
import 'package:services_admin/src/users/data/models/user.dart';
import 'package:services_admin/src/users/data/repository/user_repository.dart';
import 'package:services_admin/src/utils/extensions/datetime_extension.dart';
import 'package:services_admin/src/vehicles/data/models/vehicle.dart';
import 'package:services_admin/src/vehicles/data/repository/vehicles.dart';

class ServiceDetail extends StatelessWidget {
  static const routeName = '/service-detail';
  const ServiceDetail({
    super.key,
    required this.service,
  });
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(service.id),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                ServiceFormScreen.routeName,
                arguments: ServiceFormArguments(toEditData: service),
              );
            },
            icon: const Icon(
              Icons.edit_rounded,
            ),
          )
        ],
      ),
      body: ServiceDetailView(
        service: service,
      ),
    );
  }
}

class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({super.key, required this.service});
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailItem.withCustomValue(
            title: 'Estado:',
            value: StatusChip(
              status: service.status,
            ),
          ),
          DetailItem(
            title: 'ID:',
            value: service.id,
          ),
          DetailItem(
              title: 'Hora del Servicio:',
              value: service.serviceHour.completeDate()),
          DetailItem(
            title: 'Ruta:',
            value: service.route,
          ),
          DetailItem(
            title: 'Cupos:',
            value: service.seats.toString(),
          ),
          DetailItem(
            title: 'Ruta:',
            value: service.route,
          ),
          DetailItem(
            title: 'Conductor:',
            value: context
                .read<UserRepository>()
                .getDrivers()
                .firstWhere(
                  (element) => service.driverId == element.id,
                  orElse: () => UserModel.empty,
                )
                .name,
          ),
          DetailItem(
            title: 'Vehiculo:',
            value: context
                .read<VehicleRepository>()
                .getVehicles(service.driverId)
                .firstWhere(
                  (element) => service.vehicleId == element.id,
                  orElse: () => Vehicle.empty,
                )
                .plate,
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({
    super.key,
    required this.title,
    required this.value,
  }) : customValue = null;

  const DetailItem.withCustomValue({
    super.key,
    required this.title,
    required Widget value,
  })  : value = '',
        customValue = value;

  final String title;
  final String value;
  final Widget? customValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: customValue != null
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          customValue ??
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
        ],
      ),
    );
  }
}
