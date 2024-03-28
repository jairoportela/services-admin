import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/providers/service_form/service_form_cubit.dart';

class ServiceSubmitButton extends StatelessWidget {
  const ServiceSubmitButton({
    super.key,
    required this.isNewService,
    required this.formKey,
  });

  final bool isNewService;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormCubit, ServiceFormState>(
      builder: (context, state) {
        final status = state.submitStatus;
        if (status == SubmitStatus.sending) {
          return FilledButton.icon(
            icon: Transform.scale(
              scale: 0.5,
              child: const CircularProgressIndicator(),
            ),
            onPressed: null,
            label: Text(
              isNewService ? 'Crear' : 'Editar',
            ),
          );
        }
        return FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<ServiceFormCubit>().onSubmit();
            }
          },
          child: ButtonText(
            isNewService ? 'Crear' : 'Editar',
          ),
        );
      },
    );
  }
}
