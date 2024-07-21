class SendFromFacultyModel {
  final String petition_id;
  final String university_id;
  final String comment;
  final String faculty_id;
  SendFromFacultyModel(
      {
        required this.petition_id,
        required this.university_id,
        required this.comment,
        required this.faculty_id,

      });
  Map<String, dynamic> toJson() {
    return {
      'petition_id': petition_id,
      'university_id':university_id,
      'comment': comment,
      'faculty_id': faculty_id,
    };
  }
}
