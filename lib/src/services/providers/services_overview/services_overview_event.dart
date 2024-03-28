part of 'services_overview_bloc.dart';

sealed class ServicesOverviewEvent extends Equatable {
  const ServicesOverviewEvent();

  @override
  List<Object> get props => [];
}

class ServicesOverviewSubscriptionRequested extends ServicesOverviewEvent {}

class ServicesOverviewGetAll extends ServicesOverviewEvent {}

class ServicesOverviewFilter extends ServicesOverviewEvent {
  const ServicesOverviewFilter({
    required this.filter,
  });
  final ServiceFilter filter;
}
