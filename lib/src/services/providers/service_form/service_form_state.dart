part of 'service_form_cubit.dart';

enum SubmitStatus {
  initial,
  sending,
  success,
  error,
}

class ServiceFormState extends Equatable {
  const ServiceFormState({
    this.isNewService = true,
    this.status = ServiceStatus.inactive,
    this.submitStatus = SubmitStatus.initial,
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
      isNewService: false,
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
      ),
    );
  }
  final ServiceStatus status;
  final DateTime? serviceDate;
  final TimeOfDay? serviceHour;
  final int? seats;
  final String? route;
  final String? driverId;
  final String? vehicleId;
  final String? id;
  final SubmitStatus submitStatus;

  final bool isNewService;

  ServiceFormState copyWith({
    SubmitStatus? submitStatus,
    ServiceStatus? status,
    DateTime? Function()? serviceDate,
    TimeOfDay? Function()? serviceHour,
    int? Function()? seats,
    String? Function()? route,
    String? Function()? driverId,
    String? Function()? vehicleId,
  }) {
    return ServiceFormState(
      isNewService: isNewService,
      id: id,
      status: status ?? this.status,
      submitStatus: submitStatus ?? this.submitStatus,
      serviceDate: serviceDate != null ? serviceDate() : this.serviceDate,
      serviceHour: serviceHour != null ? serviceHour() : this.serviceHour,
      seats: seats != null ? seats() : this.seats,
      route: route != null ? route() : this.route,
      driverId: driverId != null ? driverId() : this.driverId,
      vehicleId: vehicleId != null ? vehicleId() : this.vehicleId,
    );
  }

  ServiceModel toService() {
    final idService = id ?? DateTime.now().millisecond.toString();
    final newServiceHour = combineDateTimeAndTime(serviceDate!, serviceHour!);
    return ServiceModel(
      id: idService,
      serviceHour: newServiceHour,
      waitHour: newServiceHour.subtract(const Duration(minutes: 15)),
      seats: seats ?? 0,
      status: status,
      route: route ?? '',
      driverId: driverId ?? '',
      vehicleId: vehicleId ?? '',
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
        submitStatus,
      ];
}

DateTime combineDateTimeAndTime(DateTime date, TimeOfDay time) {
  // Extraer los valores de año, mes y día del DateTime
  int year = date.year;
  int month = date.month;
  int day = date.day;

  // Extraer los valores de hora y minuto del TimeOfDay
  int hour = time.hour;
  int minute = time.minute;

  // Crear un nuevo DateTime combinando los valores
  return DateTime(year, month, day, hour, minute);
}
