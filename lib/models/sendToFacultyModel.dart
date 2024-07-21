class SendToFacultyModel {
  final String petition_id;
  final String faculty_id;
  final String comment;

  SendToFacultyModel(
      {
        required this.petition_id,
        required this.faculty_id,
        required this.comment,
      });
  Map<String, dynamic> toJson() {
    return {
      'petition_id': petition_id,
      'faculty_id': faculty_id,
      'comment': comment,
    };
  }
}
