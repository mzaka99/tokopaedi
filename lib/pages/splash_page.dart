import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/user_provider.dart';
import 'package:tokopaedi/theme.dart';

import '../providers/favorite_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late StreamSubscription<User?> _listener;

  @override
  void initState() {
    _listener = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        Future.delayed(const Duration(seconds: 3)).then((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false,
              arguments: true);
        });
      } else {
        Future.delayed(const Duration(seconds: 3)).then((_) {
          Provider.of<FavoriteProvider>(context, listen: false)
              .fetchFavoriteList();
          Provider.of<UserProvider>(context, listen: false).getData();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images_splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
