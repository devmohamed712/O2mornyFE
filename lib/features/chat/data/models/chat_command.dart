class ChatCommand {
  final String token;
  final String receiverId;
  final String content;

  ChatCommand({
    required this.token,
    required this.receiverId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {"token": token, "receiverId": receiverId, "content": content};
  }
}
