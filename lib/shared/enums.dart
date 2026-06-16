enum Roles {
  Admin("Admin"),
  ServiceProvider("ServiceProvider"),
  Client("Client");

  const Roles(this.value);
  final String value;
}

enum PlatformType {
  Android(1),
  IOS(2),
  Web(3);

  const PlatformType(this.value);
  final num value;
}

enum AccountStatus {
  Pending(1),
  UnderReview(2),
  Active(3),
  Rejected(4),
  Blocked(5),
  DeletedByUser(6);

  const AccountStatus(this.value);
  final int value;
}

enum StorageTypes {
  Token("access_token"),
  Role("role"),
  Account("account"),
  NavigateAfterCreateAccount("navigate_after_create_account");

  const StorageTypes(this.value);
  final String value;
}
