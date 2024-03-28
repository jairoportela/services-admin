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
  });
  final Status status;
  final List<ServiceModel> services;
  final String? error;

  ServicesOverviewState copyWith({
    Status? status,
    List<ServiceModel>? services,
    String? Function()? error,
  }) {
    return ServicesOverviewState(
      status: status ?? this.status,
      services: services ?? this.services,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        services,
        error,
      ];
}
