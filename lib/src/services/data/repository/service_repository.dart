import 'package:rxdart/subjects.dart';
import 'package:services_admin/src/services/data/models/models.dart';

abstract class ServiceRepository {
  Stream<List<ServiceModel>> items();
  Future<List<ServiceModel>> getAll();
  Future<bool> create(ServiceModel model);
  Future<bool> edit(ServiceModel model);
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

  @override
  Future<bool> create(ServiceModel model) async {
    try {
      //SIMULANDO TIEMPO DE ESPERA
      await Future.delayed(const Duration(seconds: 1));
      _servicesStreamController.add([
        ..._servicesStreamController.value,
        model,
      ]);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> edit(ServiceModel model) async {
    try {
      final items = [..._servicesStreamController.value];
      final index = items.indexWhere((element) => element.id == model.id);
      if (index >= 0) {
        items.replaceRange(index, index + 1, [model]);
      }

      //SIMULANDO TIEMPO DE ESPERA

      await Future.delayed(const Duration(seconds: 1));
      _servicesStreamController.add(items);
      return true;
    } catch (error) {
      return false;
    }
  }
}
