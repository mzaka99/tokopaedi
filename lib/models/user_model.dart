class UserModel {
  final String fullName;
  final String userName;
  final String email;
  String? imageUrl;

  UserModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.imageUrl,
  });
}
