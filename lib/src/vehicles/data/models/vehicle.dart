class Vehicle {
  const Vehicle({
    required this.driverId,
    required this.id,
    required this.plate,
  });

  final String driverId;
  final String id;
  final String plate;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      driverId: json['driver_id'],
      plate: json['plate'] ?? '',
    );
  }

  static const empty = Vehicle(driverId: '', id: '', plate: '');
}
