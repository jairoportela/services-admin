import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/data/models/models.dart';
import 'package:services_admin/src/services/data/models/routes_data.dart';
import 'package:services_admin/src/services/providers/service_form/service_form_cubit.dart';
import 'package:services_admin/src/users/data/repository/user_repository.dart';
import 'package:services_admin/src/utils/extensions/datetime_extension.dart';
import 'package:services_admin/src/vehicles/data/repository/vehicles.dart';

class ServiceFormView extends StatelessWidget {
  const ServiceFormView({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocSelector<ServiceFormCubit, ServiceFormState, bool>(
          selector: (state) {
            return state.isNewService;
          },
          builder: (context, isNewService) {
            return Column(
              children: [
                const StatusField(),
                const _SeparatorHeight(),
                const ServiceDateField(),
                const _SeparatorHeight(),
                const ServiceHourField(),
                const _SeparatorHeight(),
                const DriverField(),
                const _SeparatorHeight(),
                const VehicleField(),
                const _SeparatorHeight(),
                SeatsField(
                  isNewService: isNewService,
                ),
                const _SeparatorHeight(),
                RouteField(
                  isNewService: isNewService,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SeparatorHeight extends StatelessWidget {
  const _SeparatorHeight();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}

class StatusField extends StatelessWidget {
  const StatusField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Estado del servicio',
      isRequired: true,
      child: DropdownButtonFormField<ServiceStatus>(
        value: context.read<ServiceFormCubit>().state.status,
        items: ServiceStatus.values
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.title),
                ))
            .toList(),
        onChanged: context.read<ServiceFormCubit>().onChangeStatus,
        validator: (value) {
          if (value == null) return 'Valor requerido';
          return null;
        },
      ),
    );
  }
}

class DriverField extends StatelessWidget {
  const DriverField({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.read<ServiceFormCubit>().state.driverId;
    final listItems = UsersRepositoryImplementation()
        .getDrivers()
        .map((e) => DropdownMenuItem(
              value: e.id,
              child: Text(e.name),
            ))
        .toList();
    return CustomInputField(
      title: 'Conductor',
      isRequired: true,
      child: DropdownButtonFormField<String>(
        value: value,
        items: listItems,
        onChanged: context.read<ServiceFormCubit>().onChangeDriverId,
        validator: (value) {
          if (value == null) return 'Valor requerido';
          return null;
        },
      ),
    );
  }
}

class VehicleField extends StatelessWidget {
  const VehicleField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Vehiculo',
      isRequired: true,
      child: BlocSelector<ServiceFormCubit, ServiceFormState, String?>(
        selector: (state) {
          return state.driverId;
        },
        builder: (context, driverId) {
          if (driverId == null) {
            return DropdownButtonFormField<String>(
              items: const [],
              onChanged: context.read<ServiceFormCubit>().onChangeVehicleId,
              decoration: const InputDecoration(
                  labelText: 'No hay conductor seleccionado'),
            );
          }

          final listItems = VehiclesRepositoryImplementation()
              .getVehicles(driverId)
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.plate),
                  ))
              .toList();
          return BlocSelector<ServiceFormCubit, ServiceFormState, String?>(
            selector: (state) {
              return state.vehicleId;
            },
            builder: (context, value) {
              return DropdownButtonFormField<String>(
                value: value,
                items: listItems,
                onChanged: context.read<ServiceFormCubit>().onChangeVehicleId,
                validator: (value) {
                  if (value == null) return 'Valor requerido';
                  return null;
                },
              );
            },
          );
        },
      ),
    );
  }
}

class RouteField extends StatelessWidget {
  const RouteField({super.key, required this.isNewService});
  final bool isNewService;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Ruta',
      isRequired: true,
      child: DropdownButtonFormField<String>(
        value: context.read<ServiceFormCubit>().state.route,
        items: routesData,
        onChanged: isNewService
            ? context.read<ServiceFormCubit>().onChangeRoute
            : null,
        decoration: InputDecoration(
          enabled: isNewService,
        ),
        validator: (value) {
          if (value == null) return 'Valor requerido';
          return null;
        },
      ),
    );
  }
}

class ServiceDateField extends StatefulWidget {
  const ServiceDateField({super.key});

  @override
  State<ServiceDateField> createState() => _ServiceDateFieldState();
}

class _ServiceDateFieldState extends State<ServiceDateField> {
  final TextEditingController _controller = TextEditingController();

  setControllerText(DateTime? value) {
    if (value != null) {
      _controller.text = value.toDate();
    }
  }

  @override
  void initState() {
    final value = context.read<ServiceFormCubit>().state.serviceDate;
    setControllerText(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Fecha del servicio',
      isRequired: true,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            firstDate: DateTime(2024),
            lastDate: DateTime(2026),
          ).then((value) {
            setControllerText(value);
            context.read<ServiceFormCubit>().onChangeDate(value);
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) return 'Valor requerido';
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ServiceHourField extends StatefulWidget {
  const ServiceHourField({super.key});

  @override
  State<ServiceHourField> createState() => _ServiceHourFieldState();
}

class _ServiceHourFieldState extends State<ServiceHourField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final value = context.read<ServiceFormCubit>().state.serviceHour;
    setControllerText(value);
    super.didChangeDependencies();
  }

  setControllerText(TimeOfDay? value) {
    if (value != null) {
      _controller.text = value.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Hora del servicio',
      isRequired: true,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        onTap: () {
          final dateTime = DateTime.now();
          showTimePicker(
            context: context,
            initialTime: TimeOfDay(
              hour: dateTime.hour,
              minute: dateTime.minute,
            ),
          ).then((value) {
            setControllerText(value);
            context.read<ServiceFormCubit>().onChangeHour(value);
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) return 'Valor requerido';
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SeatsField extends StatelessWidget {
  const SeatsField({super.key, required this.isNewService});
  final bool isNewService;
  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Cupos',
      isRequired: true,
      child: TextFormField(
        readOnly: !isNewService,
        initialValue:
            (context.read<ServiceFormCubit>().state.seats ?? '').toString(),
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: context.read<ServiceFormCubit>().onChangeSeats,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) return 'Valor requirido';
          return null;
        },
        decoration: InputDecoration(
          enabled: isNewService,
        ),
      ),
    );
  }
}
