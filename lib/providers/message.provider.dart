import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/providers/user_provider.dart';
import 'package:tokopaedi/services/message_services.dart';

class MessageProvider with ChangeNotifier {
  bool isActive = false;
  final TextEditingController controller = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>>? getMessage() {
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        isActive = true;
        notifyListeners();
      } else {
        isActive = false;
        notifyListeners();
      }
    });
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('messages')
        .where('userId', isEqualTo: userId)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();
  }

  Future<void> addMessage({
    required BuildContext context,
    ProductModel? productModel,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).dataUser;
    await MessageServices()
        .message(
          user: user!,
          isFromUser: true,
          message: controller.text,
          productModel: productModel,
        )
        .then(
          (value) => controller.clear(),
        );
  }
}
