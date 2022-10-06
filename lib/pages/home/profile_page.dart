import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/authenticate_provider.dart';
import 'package:tokopaedi/providers/user_provider.dart';

import '../../theme.dart';
import '../../widgets/widget_custom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(defaultMargin),
            child: Consumer<UserProvider>(
              builder: (context, data, _) => Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: data.urlImageUser != null
                        ? NetworkImage(data.urlImageUser!) as ImageProvider
                        : const AssetImage(' assets/icon/profile_icon.png'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo, ${data.dataUser!.fullName}',
                          style: primaryTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          '@${data.dataUser!.userName}',
                          style: subtitleTextSytle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Ink(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(13),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => authAlertDialog(
                              context: context,
                              icon: Icons.info_outline_rounded,
                              titleText: 'Logout',
                              message: 'Are you sure ?',
                              multipleButton: true,
                              onpress: () async {
                                Provider.of<AuthenticateProvider>(context,
                                        listen: false)
                                    .logOut();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/auth', (route) => false,
                                    arguments: true);
                              }),
                        );
                      },
                      child: Image.asset(
                        'assets/icon/logout_button.png',
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: primaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          color: bgColor3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: semiBold,
                ),
              ),
              InkWell(
                  onTap: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .fetchDataToController();
                    Navigator.of(context).pushNamed('/edit-profile');
                  },
                  child: menuItem('Edit Profile')),
              menuItem('Your Orders'),
              menuItem('Help'),
              const SizedBox(
                height: 30,
              ),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: semiBold,
                ),
              ),
              menuItem('Privacy & Policy'),
              menuItem('Term of Service'),
              menuItem('Rate App'),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
