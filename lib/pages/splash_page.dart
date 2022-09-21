import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/theme.dart';

import '../providers/favorite_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Provider.of<FavoriteProvider>(context, listen: false).fetchFavoriteList();
      Navigator.pushNamed(context, '/sign-in');
    });
    super.initState();
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
                  image: AssetImage('assets/images_splash.png'))),
        ),
      ),
    );
  }
}
