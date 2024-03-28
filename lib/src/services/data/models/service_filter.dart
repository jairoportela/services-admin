import 'package:equatable/equatable.dart';
import 'package:services_admin/src/services/data/models/models.dart';

class ServiceFilter extends Equatable {
  const ServiceFilter({
    this.initialDate,
    this.finalDate,
    this.route,
    this.driverId,
  });

  final String? route;
  final DateTime? initialDate;
  final DateTime? finalDate;
  final String? driverId;

  ServiceFilter copyWith({
    String? Function()? route,
    String? Function()? driverId,
    DateTime? Function()? initialDate,
    DateTime? Function()? finalDate,
  }) =>
      ServiceFilter(
        initialDate: initialDate != null ? initialDate() : this.initialDate,
        finalDate: finalDate != null ? finalDate() : this.finalDate,
        route: route != null ? route() : this.route,
        driverId: driverId != null ? driverId() : this.driverId,
      );

  Iterable<ServiceModel> applyAll(
    Iterable<ServiceModel> services,
  ) {
    return services.where((service) => apply(
          service,
          finalDate: finalDate,
          initialDate: initialDate,
          route: route,
          driverId: driverId,
        ));
  }

  bool apply(
    ServiceModel service, {
    String? route,
    DateTime? initialDate,
    DateTime? finalDate,
    String? driverId,
  }) {
    // Verificar si hay filtro de ruta y si no coincide, retornar false
    if (route != null && service.route != route) {
      return false;
    }

    // Verificar si hay filtro de fecha inicial y si no cumple, retornar false
    if (initialDate != null && service.serviceHour.isBefore(initialDate)) {
      return false;
    }

    // Verificar si hay filtro de fecha final y si no cumple, retornar false
    if (finalDate != null && service.serviceHour.isAfter(finalDate)) {
      return false;
    }
    // Verificar si hay filtro de conductor y si no coincide, retornar false
    if (driverId != null && service.driverId != driverId) {
      return false;
    }

    // Si no se encontraron condiciones que hicieran fallar el filtro, retornar true
    return true;
  }

  @override
  List<Object?> get props => [
        initialDate,
        finalDate,
        route,
        driverId,
      ];
}
