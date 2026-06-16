import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/core/services/signalr_service.dart';
import 'package:O2morny/features/chat/data/models/chat_command.dart';
import 'package:O2morny/features/chat/data/models/message_model.dart';
import 'package:O2morny/features/chat/data/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  final SignalRService signalRService = getIt<SignalRService>();
  final ChatService chatService = getIt<ChatService>();
  List<MessageModel> messages = [];
  bool connected = false;

  ChatController();

  Future<void> connect(String token) async {
    await signalRService.connect(
      token: token,
      onMessageReceived: (data) {
        final message = MessageModel.fromJson(data);

        messages.add(message);

        notifyListeners();
      },
    );

    connected = true;

    notifyListeners();
  }

  Future<void> sendMessage({
    required String token,
    required String receiverId,
    required String content,
  }) async {
    await chatService.sendMessage(
      ChatCommand(token: token, receiverId: receiverId, content: content),
    );
  }
}
