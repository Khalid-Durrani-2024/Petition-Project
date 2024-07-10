class SignPetitionModel {
  final String user_id;
  final String signed_at;
  final String petition_id;
  final String comment;


  SignPetitionModel(
      {
        required this.user_id,
        required this.signed_at,
        required this.petition_id,
        required this.comment,
      });
  Map<String, dynamic> toJson() {
    return {

      'user_id': user_id,
      'signed_at': signed_at,
      'petition_id': petition_id,
      'comment': comment,
    };
  }
}
