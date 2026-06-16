import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/features/chat/presentation/controller/chat_controller.dart';
import 'package:O2morny/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;

  static const route = "/chat";

  const ChatPage({super.key, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = getIt<ChatController>();
  String? userId;
  String? token;
  final textController = TextEditingController();
  final AuthStorageService authStorageService = getIt<AuthStorageService>();

  @override
  void initState() {
    super.initState();
    var account = authStorageService.getAccount();
    userId = account?.Id;
    token = authStorageService.getToken();
    chatController.connect(token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Consumer<ChatController>(
        builder: (context, state, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];

                    return MessageBubble(
                      isMine: message.senderId == userId,
                      text: message.content,
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(child: TextField(controller: textController)),

                    IconButton(
                      onPressed: () async {
                        if (textController.text.trim().isEmpty) {
                          return;
                        }

                        await chatController.sendMessage(
                          token: token!,
                          receiverId: widget.receiverId,
                          content: textController.text,
                        );

                        textController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
