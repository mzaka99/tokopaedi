import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/user_provider.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

import '../theme.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: bgColor1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            )),
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                color: primaryColor,
              ))
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Consumer<UserProvider>(
          builder: (context, data, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: defaultMargin),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icon/profile_icon.png'),
                  ),
                ),
              ),
              editProfileInput(
                title: 'Name',
                controller: data.fullNameController,
              ),
              editProfileInput(
                title: 'Username',
                controller: data.userNameController,
              ),
              editProfileInput(
                title: 'Email Address',
                controller: data.emailController,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor3,
      appBar: header(),
      body: content(),
    );
  }
}
