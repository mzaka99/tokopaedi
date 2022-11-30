import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/pages/cart_page.dart';
import 'package:tokopaedi/pages/checkout_page.dart';
import 'package:tokopaedi/pages/checkout_success_page.dart';
import 'package:tokopaedi/pages/edit_profile_page.dart';
import 'package:tokopaedi/pages/home/main_page.dart';
import 'package:tokopaedi/pages/my_order_page.dart';
import 'package:tokopaedi/pages/product_page.dart';
import 'package:tokopaedi/pages/auth_page.dart';
import 'package:tokopaedi/pages/splash_page.dart';
import 'package:tokopaedi/providers/authenticate_provider.dart';
import 'package:tokopaedi/providers/cart_provider.dart';
import 'package:tokopaedi/providers/category_product_provider.dart';
import 'package:tokopaedi/providers/message.provider.dart';
import 'package:tokopaedi/providers/favorite_provider.dart';
import 'package:tokopaedi/providers/fcm_provider.dart';
import 'package:tokopaedi/providers/my_order_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/providers/user_provider.dart';
import 'package:timezone/data/latest_10y.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticateProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProductProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => MessageProvider()),
        ChangeNotifierProvider(create: (context) => MyOrderProvider()),
        ChangeNotifierProvider(create: (context) => FCMProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'TOKOPAEDI',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashPage(),
            '/auth': (context) => const SignInPage(),
            '/home': (context) => const MainPage(),
            '/edit-profile': (context) => const EditProfilePage(),
            '/product': (context) => const ProductPage(),
            '/cart': (context) => const CartPage(),
            '/checkout': (context) => const CheckoutPage(),
            '/checkout-success': (context) => const CheckoutSuccesPage(),
            '/my-orders': (context) => const MyOrderPage(),
          },
        ),
      ),
    );
  }
}
