import 'package:services_admin/src/vehicles/data/models/example_data.dart';
import 'package:services_admin/src/vehicles/data/models/vehicle.dart';

abstract class VehicleRepository {
  List<Vehicle> getVehicles(String driverId);
}

class VehicleRepositoryImplementation extends VehicleRepository {
  @override
  List<Vehicle> getVehicles(String driverId) {
    try {
      final parsedData = vehicles
          .map((json) => Vehicle.fromJson(json))
          .where((element) => element.driverId == driverId)
          .toList();

      return parsedData;
    } catch (error) {
      return [];
    }
  }
}
