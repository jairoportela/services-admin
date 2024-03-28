import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/home/presentation/widgets/home_view.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';
import 'package:services_admin/src/services/providers/services_overview/services_overview_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesOverviewBloc(
        ServiceRepositoryImplementation(),
      )
        ..add(ServicesOverviewSubscriptionRequested())
        ..add(ServicesOverviewGetAll()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Servicios'),
        ),
        body: const HomeView(),
      ),
    );
  }
}
