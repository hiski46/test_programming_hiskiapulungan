class Provinsi {
  final String id;
  final String name;

  const Provinsi({
    required this.id,
    required this.name,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(
      id: json['_id'],
      name: json['name'],
    );
  }
}
