import 'package:tokopaedi/models/product_model.dart';

class MessageModel {
  final String message;
  final String userId;
  final String username;
  final String userImage;
  final bool isFromUser;
  final ProductModel? product;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.message,
    required this.userId,
    required this.username,
    required this.userImage,
    required this.isFromUser,
    this.product,
    required this.createdAt,
    required this.updatedAt,
  });
}
