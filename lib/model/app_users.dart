class AppUser {
  static const collectionName = "users";
  static AppUser? currentUser;
  String id;
  String email;
  String username;
  // Default constructor
  AppUser({
    required this.id,
    required this.email,
    required this.username,
  });

  // Named constructor: fromJson
  AppUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        username = json['username'];

  // Method: toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
      };
}
