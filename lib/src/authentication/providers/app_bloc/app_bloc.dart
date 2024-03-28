import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:services_admin/src/authentication/data/repository/authentication_repository.dart';
import 'package:services_admin/src/authentication/data/repository/models/user_session.dart';
import 'package:services_admin/src/users/data/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const AppState.unknown(),
        ) {
    on<AppUserChanged>(_onUserChanged);
  }

  Future<void> _onUserChanged(
      AppUserChanged event, Emitter<AppState> emit) async {
    await emit.forEach(_authenticationRepository.getUserSession(),
        onData: (session) {
      if (session.status == SessionStatus.unauthenticated) {
        return const AppState.unauthenticated();
      } else {
        return AppState.authenticated(session.user);
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
}
