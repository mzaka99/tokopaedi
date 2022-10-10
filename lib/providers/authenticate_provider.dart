import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokopaedi/providers/user_provider.dart';

import '../widgets/widget_custom.dart';

class AuthenticateProvider with ChangeNotifier {
  bool isLogin = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final mAuth = FirebaseAuth.instance;

  void changeMode() {
    isLogin = !isLogin;
    clearController();
    notifyListeners();
  }

  void clearController() {
    formKey.currentState!.reset();
    fullNameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> sumbit({
    required BuildContext context,
  }) async {
    FocusManager().primaryFocus?.unfocus();
    final isValid = formKey.currentState!.validate();
    UserCredential userCredential;
    if (!isValid) {
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      if (isLogin) {
        userCredential = await mAuth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } else {
        userCredential = await mAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'full_name': fullNameController.text.trim(),
          'username': userNameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'image_url': '',
        });
      }
      if (userCredential.user != null) {
        await UserProvider().getData();
        Future.delayed(const Duration(seconds: 0)).then((_) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
          clearController();
        });
      }
    } on FirebaseAuthException catch (e) {
      var message = 'Sorry, there was an error.';
      if (e.message != null) {
        message = e.message!;
        showDialog(
          context: context,
          builder: (context) {
            return authAlertDialog(
              context: context,
              icon: Icons.error_outline_rounded,
              message: message,
            );
          },
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
