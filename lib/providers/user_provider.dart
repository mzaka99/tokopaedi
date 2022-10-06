import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../widgets/widget_custom.dart';

class UserProvider with ChangeNotifier {
  UserModel? dataUser;
  bool isLoading = false;
  bool isSucces = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final mAuth = FirebaseAuth.instance;
  File? imageUser;
  String? urlImageUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
    urlImageUser = dataUser!.imageUrl;
    notifyListeners();
  }

  bool deleteImagePicker() {
    imageUser = null;
    notifyListeners();
    return true;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 80, maxWidth: 500);
    if (pickedImage == null) {
      return;
    }
    imageUser = File(pickedImage.path);
    notifyListeners();
  }

  Future<void> updateDataUser(BuildContext context) async {
    final curentUser = FirebaseAuth.instance.currentUser!;
    passwordController.clear();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return changeEmailDialog(
          context: context,
          controller: passwordController,
          onpress: isSucces
              ? () {
                  Navigator.of(context).pop();
                  isLoading = false;
                  isSucces = false;
                  notifyListeners();
                }
              : () async {
                  isLoading = true;
                  notifyListeners();
                  final credential = EmailAuthProvider.credential(
                      email: curentUser.email!,
                      password: passwordController.text.trim());
                  curentUser.reauthenticateWithCredential(credential).then(
                        (value) => value.user
                            ?.updateEmail(emailController.text.trim()),
                      );
                  if (imageUser != null) {
                    final ref = FirebaseStorage.instance
                        .ref()
                        .child('user_image')
                        .child('${curentUser.uid}.jpg');
                    await ref.putFile(imageUser!);
                    final url = await ref.getDownloadURL();
                    await users.doc(curentUser.uid).update({
                      'image_url': url,
                    });
                  }
                  await users.doc(curentUser.uid).update({
                    'full_name': fullNameController.text.trim(),
                    'username': userNameController.text.trim(),
                    'email': emailController.text.trim(),
                  }).then((_) {
                    getData();
                    isLoading = false;
                    isSucces = true;
                    notifyListeners();
                  });
                },
        );
      },
    );
  }
}
