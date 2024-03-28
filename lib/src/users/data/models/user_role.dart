import 'package:services_admin/src/utils/decoder_enum/decoder_enum.dart';

enum UserRole {
  driver(
    'Conductor',
  ),
  client(
    'Cliente',
  ),
  admin(
    'Admin',
  ),
  ;

  const UserRole(
    this.title,
  );

  final String title;
}

UserRole getRoleByKey(String? key) {
  return DecoderEnum.getData<String?, UserRole>(
    key,
    decoder: _rolesMap,
    defaultValue: UserRole.client,
  );
}

Map<String, UserRole> _rolesMap = {
  'Conductor': UserRole.driver,
  'Cliente': UserRole.client,
  'Admin': UserRole.admin,
};
