part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,

  unknown,
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const AppState.authenticated(UserModel user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.unknown() : this._(status: AppStatus.unknown);

  final AppStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];

  @override
  String toString() {
    return 'AppState($status, ${user.toString()})';
  }
}
