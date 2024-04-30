class MWUser {
  static const String kId = 'id';
  static const String kEmail = 'email';
  static const String kDisplayName = 'displayName';
  static const String kNotificationToken = 'notificationToken';

  String? id;
  String? email;
  String? displayName;
  String? notificationToken;

  MWUser({
    this.id,
    this.email,
    this.displayName,
    this.notificationToken,
  });

  MWUser.fromJson(Map<String, dynamic> json) {
    id = json[kId];
    email = json[kEmail];
    displayName = json[kDisplayName];
    notificationToken = json[kNotificationToken];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[kId] = id;
    data[kEmail] = email;
    data[kDisplayName] = displayName;
    data[kNotificationToken] = notificationToken;
    return data;
  }
}
