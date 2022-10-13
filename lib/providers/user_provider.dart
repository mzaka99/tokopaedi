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
  bool loadDataUser = false;
  bool isLoading = false;
  bool isSucces = false;
  bool activeSubmit = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final mAuth = FirebaseAuth.instance;
  File? imageUser;

  String? urlImageUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> getData() async {
    loadDataUser = true;
    notifyListeners();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(userId);
    UserModel? loadData;

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      loadData = UserModel(
        fullName: snapshot.get('full_name'),
        userName: snapshot.get('username'),
        email: snapshot.get('email'),
        imageUrl: snapshot.get('image_url'),
      );
    });
    dataUser = loadData;

    loadDataUser = false;
    notifyListeners();
  }

  void fetchDataToController() {
    fullNameController.text = dataUser!.fullName;
    userNameController.text = dataUser!.userName;
    emailController.text = dataUser!.email;
    urlImageUser = dataUser!.imageUrl;
    fullNameController.addListener(() {
      if (fullNameController.text == dataUser!.fullName &&
          userNameController.text == dataUser!.userName &&
          imageUser == null) {
        activeSubmit = false;
        notifyListeners();
      } else {
        activeSubmit = true;
        notifyListeners();
      }
    });
    userNameController.addListener(() {
      if (fullNameController.text == dataUser!.fullName &&
          userNameController.text == dataUser!.userName &&
          imageUser == null) {
        activeSubmit = false;
        notifyListeners();
      } else {
        activeSubmit = true;
        notifyListeners();
      }
    });
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
    activeSubmit = true;
    notifyListeners();
  }

  Future<void> updateDataUser(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final curentUser = FirebaseAuth.instance.currentUser!;
      isLoading = true;
      notifyListeners();
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
      }).then((_) {
        getData();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return customAlertDialog(
              context: context,
              onpress: () {
                Navigator.of(context).pop();
                notifyListeners();
              },
            );
          },
        );
        activeSubmit = false;
        isLoading = false;
        notifyListeners();
      });
    }
  }

  void userLogOut() {
    dataUser = null;
    notifyListeners();
  }
}
