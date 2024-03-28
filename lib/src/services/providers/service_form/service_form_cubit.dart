import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:services_admin/src/services/data/models/service_model.dart';
import 'package:services_admin/src/services/data/models/service_status.dart';

part 'service_form_state.dart';

class ServiceFormCubit extends Cubit<ServiceFormState> {
  ServiceFormCubit({required ServiceModel? serviceToEdit})
      : super(
          serviceToEdit == null
              ? const ServiceFormState()
              : ServiceFormState.fromService(service: serviceToEdit),
        );

  void onChangeDate(DateTime? value) {
    emit(state.copyWith(serviceDate: () => value));
  }

  void onChangeHour(TimeOfDay? value) {
    emit(state.copyWith(serviceHour: () => value));
  }

  void onChangeSeats(String? value) {
    final resultValue = int.tryParse(value ?? '');
    emit(state.copyWith(seats: () => resultValue));
  }

  void onChangeRoute(String? value) {
    emit(state.copyWith(route: () => value));
  }

  void onChangeStatus(ServiceStatus? value) {
    emit(state.copyWith(status: value));
  }

  void onChangeDriverId(String? value) {
    emit(state.copyWith(driverId: () => value));
  }

  void onChangeVehicleId(String? value) {
    emit(state.copyWith(vehicleId: () => value));
  }

  @override
  void onChange(Change<ServiceFormState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
