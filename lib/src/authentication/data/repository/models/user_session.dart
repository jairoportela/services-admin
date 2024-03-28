import 'package:services_admin/src/users/data/models/user.dart';

enum SessionStatus {
  authenticated,

  unauthenticated,
}

class UserSession {
  const UserSession._({
    this.user = UserModel.empty,
    this.status = SessionStatus.unauthenticated,
  });

  const UserSession.authenticated(UserModel user)
      : this._(
          user: user,
          status: SessionStatus.authenticated,
        );

  const UserSession.unautheticated() : this._();

  final UserModel user;

  final SessionStatus status;
}
