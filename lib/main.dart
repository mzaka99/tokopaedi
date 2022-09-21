import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/pages/cart_page.dart';
import 'package:tokopaedi/pages/checkout_page.dart';
import 'package:tokopaedi/pages/checkout_success_page.dart';
import 'package:tokopaedi/pages/detail_chat_page.dart';
import 'package:tokopaedi/pages/edit_profile_page.dart';
import 'package:tokopaedi/pages/home/main_page.dart';
import 'package:tokopaedi/pages/product_page.dart';
import 'package:tokopaedi/pages/sign_in_page.dart';
import 'package:tokopaedi/pages/sign_up_page.dart';
import 'package:tokopaedi/pages/splash_page.dart';
import 'package:tokopaedi/providers/favorite_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashPage(),
            '/sign-in': (context) => const SignInPage(),
            '/sign-up': (context) => const SignUpPage(),
            '/home': (context) => const MainPage(),
            '/chat': (context) => const DetailChatPage(),
            '/edit-profile': (context) => const EditProfilePage(),
            '/product': (context) => const ProductPage(),
            '/cart': (context) => const CartPage(),
            '/checkout': (context) => const CheckoutPage(),
            '/checkout-success': (context) => const CheckoutSuccesPage(),
          },
        ),
      ),
    );
  }
}
