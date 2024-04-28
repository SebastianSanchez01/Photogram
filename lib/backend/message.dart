class Message {
  final String message;
  final String senderName;
  final String timeStamp;
  final String senderId;
  final String receiverId;

  Message(
      {required this.message,
      required this.senderName,
      required this.timeStamp,
      required this.senderId,
      required this.receiverId});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderName': senderName,
      'timeStamp': timeStamp,
      'senderId': senderId,
      'receiverId': receiverId
    };
  }
}
