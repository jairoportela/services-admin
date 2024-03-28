import 'package:services_admin/src/users/data/models/example_data.dart';
import 'package:services_admin/src/users/data/models/user.dart';

abstract class UserRepository {
  List<UserModel> getDrivers();
}

class UserRepositoryImplementation extends UserRepository {
  @override
  List<UserModel> getDrivers() {
    try {
      final parsedData =
          drivers.map((json) => UserModel.fromJson(json)).toList();

      return parsedData;
    } catch (error) {
      return [];
    }
  }
}
