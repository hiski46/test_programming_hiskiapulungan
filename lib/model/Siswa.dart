class Siswa {
  final String id;
  final String name;
  final String gender;
  final String birthDate;
  final String province;
  final String city;
  final String photo;

  const Siswa({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.province,
    required this.city,
    required this.photo,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['_id'],
      name: json['name'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      province: json['province'],
      city: json['city'],
      photo: json['photo'],
    );
  }
}
