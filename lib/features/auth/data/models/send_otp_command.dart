class SendOtpCommand {
  final String PhoneNumber;

  SendOtpCommand({required this.PhoneNumber});

  Map<String, dynamic> toJson() {
    return {"PhoneNumber": PhoneNumber};
  }
}
