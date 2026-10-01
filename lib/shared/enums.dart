enum Roles {
  Admin("Admin"),
  User("User");

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
  Active(1),
  Blocked(2),
  DeletedByUser(3);

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
