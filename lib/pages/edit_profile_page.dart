import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
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
              Provider.of<UserProvider>(context, listen: false)
                  .deleteImagePicker();
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
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false)
                    .updateDataUser(context);
              },
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
              SizedBox(
                height: defaultMargin,
              ),
              data.urlImageUser == null && data.imageUser != null
                  ? const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/icon/profile_icon.png'),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: data.dataUser!.imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer(
                          child: Container(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
              TextButton.icon(
                onPressed: () {
                  data.pickImage();
                },
                icon: const Icon(Icons.camera_alt_rounded),
                label: Text(
                  'Change Photo',
                  style: priceTextStyle,
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
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async =>
          Provider.of<UserProvider>(context, listen: false).deleteImagePicker(),
      child: Scaffold(
        backgroundColor: bgColor3,
        appBar: header(),
        body: SingleChildScrollView(
          child: content(),
        ),
      ),
    );
  }
}
