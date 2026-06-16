import 'package:O2morny/core/network/api_constants.dart';
import 'package:O2morny/features/chat/data/models/chat_command.dart';
import 'package:dio/dio.dart';

class ChatService {
  final String apiChatUrl = "${ApiConstants.apiUrl}Chat/";
  final Dio dio;

  ChatService(this.dio);

  Future<void> sendMessage(ChatCommand request) async {
    await dio.post(
      "${apiChatUrl}login",
      data: request.toJson(),
      options: Options(contentType: Headers.jsonContentType),
    );
  }
}
