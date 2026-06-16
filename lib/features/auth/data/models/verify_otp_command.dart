class VerifyOtpCommand {
  final String PhoneNumber;
  final String OTP;

  VerifyOtpCommand({required this.PhoneNumber, required this.OTP});

  Map<String, dynamic> toJson() {
    return {"PhoneNumber": PhoneNumber, "OTP": OTP};
  }
}
