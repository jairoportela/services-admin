import 'package:rxdart/subjects.dart';
import 'package:services_admin/src/authentication/data/repository/models/user_session.dart';
import 'package:services_admin/src/users/data/models/user.dart';
import 'package:services_admin/src/users/data/models/user_role.dart';

abstract class AuthenticationRepository {
  Stream<UserSession> getUserSession();
}

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  AuthenticationRepositoryImplementation() {
    _init();
  }
  void _init() {
    //TODO: Cambiar usuario para ver o no el home (Hay que hacer un HotReload para ver el cambio)
    const UserModel user =
        UserModel(id: '1', role: UserRole.admin, name: 'Jairo');

    if (user.role == UserRole.admin) {
      _userStreamController.add(const UserSession.authenticated(user));
    } else {
      _userStreamController.add(const UserSession.unautheticated());
    }
  }

  @override
  Stream<UserSession> getUserSession() =>
      _userStreamController.asBroadcastStream();

  final _userStreamController =
      BehaviorSubject<UserSession>.seeded(const UserSession.unautheticated());
}
