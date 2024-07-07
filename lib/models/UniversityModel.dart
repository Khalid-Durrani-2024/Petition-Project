class UniversityModel {
  final String name;
  final String location;
  final String created_at;

  UniversityModel(
      {
        required this.name,
        required this.location,
        required this.created_at,
        });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'created_at': created_at,
    };
  }
}
