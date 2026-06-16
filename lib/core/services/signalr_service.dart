import 'package:O2morny/core/network/api_constants.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection connection;

  Future<void> connect({
    required String token,
    required Function(dynamic data) onMessageReceived,
  }) async {
    connection = HubConnectionBuilder()
        .withUrl(
          "${ApiConstants.apiUrl}/NotificationHub",
          options: HttpConnectionOptions(accessTokenFactory: () async => token),
        )
        .withAutomaticReconnect()
        .build();

    connection.on("ReceiveMessage", (data) {
      if (data != null) {
        onMessageReceived(data[0]);
      }
    });

    await connection.start();
  }

  Future<void> disconnect() async {
    await connection.stop();
  }
}
