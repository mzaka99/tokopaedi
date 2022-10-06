import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? dataUser;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<dynamic> getData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(userId);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      dataUser = UserModel(
        fullName: snapshot.get('full_name'),
        userName: snapshot.get('username'),
        email: snapshot.get('email'),
        imageUrl: snapshot.get('image_url'),
      );
      notifyListeners();
    });
  }

  void fetchDataToController() {
    fullNameController.text = dataUser!.fullName;
    userNameController.text = dataUser!.userName;
    emailController.text = dataUser!.email;
    notifyListeners();
  }
}
