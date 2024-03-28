part of 'services_overview_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  error,
}

class ServicesOverviewState extends Equatable {
  const ServicesOverviewState({
    this.status = Status.initial,
    this.services = const [],
    this.error,
    this.filter = const ServiceFilter(),
  });
  final Status status;
  final List<ServiceModel> services;
  final String? error;
  final ServiceFilter filter;

  Iterable<ServiceModel> get filteredServices => filter.applyAll(services);

  ServicesOverviewState copyWith({
    Status? status,
    List<ServiceModel>? services,
    String? Function()? error,
    ServiceFilter? filter,
  }) {
    return ServicesOverviewState(
      status: status ?? this.status,
      services: services ?? this.services,
      error: error != null ? error() : this.error,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        services,
        error,
        filter,
      ];
}
