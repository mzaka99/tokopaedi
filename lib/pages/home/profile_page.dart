import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
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
                  data.dataUser!.imageUrl == ''
                      ? const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/icon/profile_icon.png'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: data.dataUser!.imageUrl!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer(
                              child: Container(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
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
                                    .logOut(context);
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil(
                                        '/auth', (route) => false,
                                        arguments: true)
                                    .then((value) => Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .userLogOut());
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
        child: SingleChildScrollView(
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
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/my-orders');
                    },
                    child: menuItem('Your Orders')),
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
