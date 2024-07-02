class Faculty {
  final String name;
  final String university_id;
  final String email;
  final String password;
  final String university_name;
  final String role;


  Faculty(
      {
        required this.name,
        required this.university_id,
        required this.email,
        required this.password,
        required this.university_name,
        required this.role,});
    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'university_id': university_id,
      'email': email,
      'password': password,
      'university_name': university_name,
      'role': role,
    };
  }
}
