import 'package:rxdart/subjects.dart';
import 'package:services_admin/src/services/data/models/models.dart';

abstract class ServiceRepository {
  Stream<List<ServiceModel>> items();
  Future<List<ServiceModel>> getAll();
}

class ServiceRepositoryImplementation extends ServiceRepository {
  final _servicesStreamController =
      BehaviorSubject<List<ServiceModel>>.seeded(const []);

  @override
  Stream<List<ServiceModel>> items() =>
      _servicesStreamController.asBroadcastStream();

  @override
  Future<List<ServiceModel>> getAll() async {
    try {
      //SIMULANDO TIEMPO DE ESPERA
      await Future.delayed(const Duration(seconds: 1));
      final parsedServices =
          services.map((json) => ServiceModel.fromJson(json)).toList();
      _servicesStreamController.add(parsedServices);
      return parsedServices;
    } catch (error) {
      return [];
    }
  }
}
