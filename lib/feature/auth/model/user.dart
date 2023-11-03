class User {
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        accessToken = json['accessToken'] as String?;

  String? id;
  String? accessToken;
}
