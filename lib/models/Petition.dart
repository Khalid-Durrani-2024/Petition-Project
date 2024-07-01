class Petition {
  final String type;
  final String date;
  final String title;
  final String sender;
  final String description;
  final String receiver;
  final String status;
  final String tracking;

  Petition(
      {required this.type,
      required this.date,
      required this.title,
      required this.sender,
      required this.description,
      required this.receiver,
      required this.status,
      required this.tracking});
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'date': date,
      'title': title,
      'sender': sender,
      'description': description,
      'receiver': receiver,
      'status': status,
      'tracking': tracking,
    };
  }
}
