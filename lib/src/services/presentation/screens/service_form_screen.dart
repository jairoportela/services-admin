import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';
import 'package:services_admin/src/services/presentation/screens/service_detail.dart';
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
        repository: RepositoryProvider.of<ServiceRepository>(context),
      ),
      child: ServiceFormBuilder(
        arguments: arguments,
      ),
    );
  }
}

class ServiceFormBuilder extends StatefulWidget {
  const ServiceFormBuilder({super.key, required this.arguments});
  final ServiceFormArguments arguments;

  @override
  State<ServiceFormBuilder> createState() => _ServiceFormBuilderState();
}

class _ServiceFormBuilderState extends State<ServiceFormBuilder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ServiceFormArguments(:isNewService) = widget.arguments;
    return BlocListener<ServiceFormCubit, ServiceFormState>(
      listener: (context, state) {
        final status = state.submitStatus;
        if (status == SubmitStatus.success && isNewService) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Creado correctamente.')));
          Navigator.pop(context);
        }
        if (status == SubmitStatus.success && !isNewService) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Editado correctamente.')));
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            ServiceDetail.routeName,
            arguments: state.toService(),
          );
        }
        if (status == SubmitStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Se ha producido un error.')));
        }
      },
      listenWhen: (previous, current) =>
          previous.submitStatus != current.submitStatus,
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(isNewService ? 'Crear servicio' : 'Editar servicio'),
        ),
        body: ServiceFormView(formKey: _formKey),
        bottomNavigationBar: BottomAppBar(
          child: ServiceSubmitButton(
            isNewService: isNewService,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }
}
