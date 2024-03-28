import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/services/presentation/widgets/service_card.dart';
import 'package:services_admin/src/services/providers/services_overview/services_overview_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesOverviewBloc, ServicesOverviewState>(
      builder: (context, state) {
        final status = state.status;
        return switch (status) {
          Status.loading || Status.initial => const Center(
              child: CircularProgressIndicator(),
            ),
          Status.success => ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              itemBuilder: (context, index) {
                final data = state.filteredServices.elementAt(index);
                return ServiceCard(service: data);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.filteredServices.length,
            ),
          Status.error => Text(state.error ?? ''),
        };
      },
    );
  }
}
