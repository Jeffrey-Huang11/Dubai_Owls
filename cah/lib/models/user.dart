class User {
  int id;
  String username;
  String password;

  static String tableName = "'public.user'";
  User({
    this.id = 0,
    this.username = "username",
    this.password = "password",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password}';
  }
}
