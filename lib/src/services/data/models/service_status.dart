import 'package:flutter/material.dart';
import 'package:services_admin/src/utils/decoder_enum/decoder_enum.dart';

enum ServiceStatus {
  active(
    'Activo',
    Colors.green,
  ),
  inactive(
    'Inactivo',
    Colors.orange,
  ),
  finished(
    'Terminado',
    Colors.blue,
  ),
  ;

  const ServiceStatus(
    this.title,
    this.color,
  );

  final String title;
  final Color color;
}

ServiceStatus getServicesStatusByKey(String? key) {
  return DecoderEnum.getData<String?, ServiceStatus>(key,
      decoder: _categoriesMap, defaultValue: ServiceStatus.inactive);
}

Map<String, ServiceStatus> _categoriesMap = {
  'Activo': ServiceStatus.active,
  'Inactivo': ServiceStatus.inactive,
  'Terminado': ServiceStatus.finished,
};
