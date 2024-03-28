import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/home/presentation/widgets/home_view.dart';
import 'package:services_admin/src/services/data/models/service_filter.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';
import 'package:services_admin/src/services/presentation/screens/service_form_screen.dart';
import 'package:services_admin/src/services/presentation/widgets/filter_service_modal.dart';
import 'package:services_admin/src/services/providers/services_overview/services_overview_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ServicesOverviewBloc(
        RepositoryProvider.of<ServiceRepository>(context),
      )
        ..add(ServicesOverviewSubscriptionRequested())
        ..add(ServicesOverviewGetAll()),
      child: Scaffold(
        appBar: AppBar(
          title: const TitleText('Servicios'),
          actions: const [FilterIcon()],
        ),
        body: const HomeView(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                ServiceFormScreen.routeName,
                arguments: ServiceFormArguments(toEditData: null),
              );
            },
            child: const Icon(
              Icons.add,
            )),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return SearchFilterModal(
                initialFilters:
                    context.read<ServicesOverviewBloc>().state.filter,
              );
            },
          ).then((value) {
            if (value is ServiceFilter) {
              context.read<ServicesOverviewBloc>().add(
                    ServicesOverviewFilter(filter: value),
                  );
            }
          });
        },
        icon: const Icon(
          Icons.filter_alt_rounded,
        ));
  }
}
