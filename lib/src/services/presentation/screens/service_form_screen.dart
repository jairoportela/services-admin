import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/presentation/screens/service_submit_button.dart';
import 'package:services_admin/src/services/presentation/widgets/service_form_view.dart';
import 'package:services_admin/src/services/providers/service_form/service_form_cubit.dart';

class ServiceFormArguments {
  final ServiceModel? toEditData;

  ServiceFormArguments({required this.toEditData});

  bool get isNewService => toEditData == null;
}

class ServiceFormScreen extends StatelessWidget {
  const ServiceFormScreen({
    super.key,
    required this.arguments,
  });
  static const routeName = 'service-form';
  final ServiceFormArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceFormCubit(
        serviceToEdit: arguments.toEditData,
      ),
      child: ServiceFormBuilder(
        arguments: arguments,
      ),
    );
  }
}

class ServiceFormBuilder extends StatelessWidget {
  const ServiceFormBuilder({super.key, required this.arguments});
  final ServiceFormArguments arguments;

  @override
  Widget build(BuildContext context) {
    final ServiceFormArguments(:isNewService) = arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewService ? 'Crear servicio' : 'Editar servicio'),
      ),
      body: const ServiceFormView(),
      bottomNavigationBar: BottomAppBar(
        child: ServiceSubmitButton(isNewService: isNewService),
      ),
    );
  }
}
