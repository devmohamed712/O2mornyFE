class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      content: json["content"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
