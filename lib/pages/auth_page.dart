import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/authenticate_provider.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

import '../theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static TextEditingController fullNameController = TextEditingController();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget header({required String title, required String subtitle}) {
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              subtitle,
              style: subtitleTextSytle,
            ),
          ],
        ),
      );
    }

    Widget footer({required String text, required String authText}) {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: subtitleTextSytle.copyWith(
                fontSize: 12,
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthenticateProvider>(context, listen: false)
                    .changeMode();
              },
              child: Text(
                authText,
                style: purpleTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget signInButton(String text, bool isLogin) {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {
            Provider.of<AuthenticateProvider>(context, listen: false).sumbit(
              context: context,
            );
          }
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('/home', (route) => false);
          ,
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            text,
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Consumer<AuthenticateProvider>(
              builder: (context, authData, _) => Form(
                key: authData.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(
                        title: authData.isLogin ? 'Login' : 'Sign Up',
                        subtitle: authData.isLogin
                            ? 'Sign In to Continue'
                            : 'Register and Happy Shoping'),
                    SizedBox(
                      height: authData.isLogin ? 70 : 50,
                    ),
                    if (!authData.isLogin)
                      customInput(
                        titleText: 'Full Name',
                        hintText: 'Your Full Name',
                        icon: 'assets/icon/fullname_icon.png',
                        controller: authData.fullNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harap masukan nama lengkap anda.';
                          }
                          return null;
                        },
                        key: const ValueKey('fullName'),
                        keyboardType: TextInputType.name,
                      ),
                    if (!authData.isLogin)
                      customInput(
                        titleText: 'Username',
                        hintText: 'Your Username',
                        icon: 'assets/icon/username_icon.png',
                        controller: authData.userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harap masukan nama lengkap anda.';
                          }
                          return null;
                        },
                        key: const ValueKey('username'),
                        keyboardType: TextInputType.name,
                      ),
                    customInput(
                      titleText: 'Email Address',
                      hintText: 'Your Email Address',
                      icon: 'assets/icon/email_icon.png',
                      controller: authData.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukan nama lengkap anda.';
                        }
                        return null;
                      },
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    customInput(
                      titleText: 'Password',
                      hintText: 'Your Password',
                      icon: 'assets/icon/password_icon.png',
                      controller: authData.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukan nama lengkap anda.';
                        }
                        return null;
                      },
                      key: const ValueKey('password'),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    authData.isLoading
                        ? Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              width: 50,
                              child: const CircularProgressIndicator(),
                            ),
                          )
                        : signInButton(authData.isLogin ? 'Sign In' : 'Sign Up',
                            authData.isLogin),
                    SizedBox(
                      height: defaultMargin,
                    ),
                    footer(
                        text: authData.isLogin
                            ? 'Don\'t have an account? '
                            : 'Already have an account? ',
                        authText: authData.isLogin ? 'Sign Up' : 'Sign In'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
