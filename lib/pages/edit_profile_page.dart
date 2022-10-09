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
              FocusScope.of(context).unfocus();
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
          Consumer<UserProvider>(
            builder: (context, data, _) => IconButton(
              onPressed: data.activeSubmit
                  ? () {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateDataUser(context);
                    }
                  : null,
              icon: const Icon(
                Icons.check,
                color: primaryColor,
              ),
            ),
          ),
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
          builder: (context, data, _) => Form(
            key: data.formKey,
            child: Column(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty.';
                    }
                  },
                ),
                editProfileInput(
                  title: 'Username',
                  controller: data.userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username cannot be empty.';
                    }
                  },
                ),
                editProfileInput(
                  title: 'Email Address',
                  controller: data.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot be empty.';
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
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
