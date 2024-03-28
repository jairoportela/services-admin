import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/data/models/models.dart';
import 'package:services_admin/src/services/data/models/routes_data.dart';
import 'package:services_admin/src/services/providers/service_form/service_form_cubit.dart';
import 'package:services_admin/src/utils/extensions/datetime_extension.dart';

class ServiceFormView extends StatefulWidget {
  const ServiceFormView({super.key});

  @override
  State<ServiceFormView> createState() => _ServiceFormViewState();
}

class _ServiceFormViewState extends State<ServiceFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            StatusField(),
            _SeparatorHeight(),
            ServiceDateField(),
            _SeparatorHeight(),
            ServiceHourField(),
            _SeparatorHeight(),
            SeatsField(),
            _SeparatorHeight(),
            RouteField(),
            _SeparatorHeight(),
            DriverField(),
            _SeparatorHeight(),
            VehicleField(),
          ],
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
      ),
    );
  }
}

class DriverField extends StatelessWidget {
  const DriverField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomInputField(
      title: 'Conductor',
      isRequired: true,
      child: Placeholder(),
    );
  }
}

class VehicleField extends StatelessWidget {
  const VehicleField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomInputField(
      title: 'Vehiculo',
      isRequired: true,
      child: Placeholder(),
    );
  }
}

class RouteField extends StatelessWidget {
  const RouteField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Ruta',
      isRequired: true,
      child: DropdownButtonFormField<String>(
        value: context.read<ServiceFormCubit>().state.route,
        items: routesData,
        onChanged: context.read<ServiceFormCubit>().onChangeRoute,
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
  const SeatsField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Cupos',
      isRequired: true,
      child: TextFormField(
        initialValue: context.read<ServiceFormCubit>().state.seats.toString(),
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: context.read<ServiceFormCubit>().onChangeSeats,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty) return 'Valor requirido';
          return null;
        },
      ),
    );
  }
}
