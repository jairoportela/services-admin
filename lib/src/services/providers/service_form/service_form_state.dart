part of 'service_form_cubit.dart';

class ServiceFormState extends Equatable {
  const ServiceFormState({
    this.isNewService = false,
    this.status = ServiceStatus.inactive,
    this.serviceDate,
    this.serviceHour,
    this.seats,
    this.route,
    this.driverId,
    this.vehicleId,
    this.id,
  });

  factory ServiceFormState.fromService({
    required ServiceModel service,
  }) {
    final ServiceModel(
      :driverId,
      :vehicleId,
      :id,
      :route,
      :seats,
      :serviceHour,
      :status,
    ) = service;
    return ServiceFormState(
        isNewService: true,
        id: id,
        driverId: driverId,
        route: route,
        seats: seats,
        status: status,
        vehicleId: vehicleId,
        serviceDate: serviceHour,
        serviceHour: TimeOfDay(
          hour: serviceHour.hour,
          minute: serviceHour.minute,
        ));
  }
  final ServiceStatus status;
  final DateTime? serviceDate;
  final TimeOfDay? serviceHour;
  final int? seats;
  final String? route;
  final String? driverId;
  final String? vehicleId;
  final String? id;

  final bool isNewService;

  ServiceFormState copyWith({
    ServiceStatus? status,
    DateTime? Function()? serviceDate,
    TimeOfDay? Function()? serviceHour,
    int? Function()? seats,
    String? Function()? route,
    String? Function()? driverId,
    String? Function()? vehicleId,
  }) {
    return ServiceFormState(
      status: status ?? this.status,
      serviceDate: serviceDate != null ? serviceDate() : this.serviceDate,
      serviceHour: serviceHour != null ? serviceHour() : this.serviceHour,
      seats: seats != null ? seats() : this.seats,
      route: route != null ? route() : this.route,
      driverId: driverId != null ? driverId() : this.driverId,
      vehicleId: vehicleId != null ? vehicleId() : this.vehicleId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        serviceDate,
        serviceHour,
        seats,
        route,
        driverId,
        vehicleId,
        id,
        isNewService,
      ];
}
