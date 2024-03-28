import 'package:equatable/equatable.dart';
import 'package:services_admin/src/services/data/models/service_status.dart';

class ServiceModel extends Equatable {
  final String id;
  final DateTime serviceHour;
  final DateTime waitHour;
  final int seats;
  final ServiceStatus status;
  final String route;
  final String driverId;
  final String userId;

  const ServiceModel({
    required this.id,
    required this.serviceHour,
    required this.waitHour,
    required this.seats,
    required this.status,
    required this.route,
    required this.driverId,
    required this.userId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      serviceHour: DateTime.parse(json['horaServicio']),
      waitHour: DateTime.parse(json['horaEspera']),
      seats: json['cupos'],
      status: getServicesStatusByKey(json['estado']),
      route: json['ruta'],
      driverId: json['conductorRef'],
      userId: json['vehiculoRef'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        serviceHour,
        waitHour,
        seats,
        status,
        route,
        driverId,
        userId,
      ];
}
