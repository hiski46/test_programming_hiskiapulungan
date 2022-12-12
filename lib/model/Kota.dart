class Kota {
  final String id;
  final String name;

  const Kota({
    required this.id,
    required this.name,
  });

  factory Kota.fromJson(Map<String, dynamic> json) {
    return Kota(
      id: json['_id'],
      name: json['name'],
    );
  }
}
