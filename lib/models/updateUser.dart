class updateUserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String university_id;
  final String created_at;
  final String role;


  updateUserModel(
      {
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.university_id,
        required this.created_at,
        required this.role,});
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'email': email,
      'password': password,
      'university_id': university_id,
      'created_at':created_at,
      'role': role,
    };
  }
}
