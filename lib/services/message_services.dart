import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/models/user_model.dart';

class MessageServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> message({
    required UserModel user,
    required bool isFromUser,
    required String message,
    ProductModel? productModel,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      firestore.collection('messages').add({
        'userId': currentUser!.uid,
        'username': user.userName,
        'userImages': user.imageUrl,
        'isFromUser': true,
        'message': message,
        'product': productModel == null
            ? null
            : {
                'id': productModel.id,
                'name': productModel.name,
                'price': productModel.price,
                'description': productModel.description,
                'categoriesId': productModel.categoriesId,
                'imageUrl': productModel.imageUrl[0].url,
              },
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
