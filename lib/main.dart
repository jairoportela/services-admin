import 'package:flutter/material.dart';
import 'package:services_admin/app.dart';
import 'package:services_admin/src/authentication/data/repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthenticationRepository authRepository =
      AuthenticationRepositoryImplementation();
  await authRepository.getUserSession().first;
  runApp(ServicesApp(
    authenticationRepository: authRepository,
  ));
}
