import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:services_admin/src/services/data/models/service_filter.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/data/repository/service_repository.dart';

part 'services_overview_event.dart';
part 'services_overview_state.dart';

typedef _Emitter = Emitter<ServicesOverviewState>;

class ServicesOverviewBloc
    extends Bloc<ServicesOverviewEvent, ServicesOverviewState> {
  ServicesOverviewBloc(this._repository)
      : super(const ServicesOverviewState()) {
    on<ServicesOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<ServicesOverviewGetAll>(_onGetItems);
    on<ServicesOverviewFilter>(_onFilter);
  }

  void _onSubscriptionRequested(
    ServicesOverviewSubscriptionRequested event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(status: Status.loading, error: () => null));
    await emit.forEach<List<ServiceModel>>(
      _repository.items(),
      onData: (items) => state.copyWith(
        status: Status.success,
        services: items,
        error: () => null,
      ),
      onError: (error, __) {
        String? errorMessage = error.toString();

        return state.copyWith(
          status: Status.error,
          error: () => errorMessage,
        );
      },
    );
  }

  Future<void> _onGetItems(
    ServicesOverviewGetAll event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(status: Status.loading, error: () => null));
    await _repository.getAll();
  }

  Future<void> _onFilter(
    ServicesOverviewFilter event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(
      filter: event.filter,
    ));
  }

  final ServiceRepository _repository;
}
