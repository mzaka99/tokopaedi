import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

Widget customInput({
  required String titleText,
  required Key key,
  required TextEditingController controller,
  bool obscureText = false,
  String? Function(String?)? validator,
  required String hintText,
  required String icon,
  required TextInputType keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        titleText,
        style: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      TextFormField(
        key: ValueKey(key),
        textInputAction: TextInputAction.done,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: primaryTextStyle,
        decoration: inputDecor(
          hintText: hintText,
          assetIcon: icon,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    ]),
  );
}

Widget emptyContent({
  required String assetIcon,
  required String title,
  required String subtitle,
  VoidCallback? onpress,
  bool withButton = true,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetIcon,
          width: 80,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          subtitle,
          style: secondaryTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        if (withButton)
          SizedBox(
            height: 44,
            child: TextButton(
              onPressed: onpress,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              child: Text(
                'Explore Store',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget editProfileInput({
  required String title,
  required TextEditingController controller,
  String? Function(String?)? validator,
  String? hintText,
  bool enabled = true,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: defaultMargin,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: secondaryTextStyle.copyWith(
            fontSize: 13,
          ),
        ),
        TextFormField(
          style: enabled ? primaryTextStyle : subtitleTextSytle,
          controller: controller,
          validator: validator,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: primaryTextStyle,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: subtitleTextColor,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: subtitleTextColor,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: alertColor,
              ),
            ),
            errorStyle: alertTextStyle,
          ),
        )
      ],
    ),
  );
}

InputDecoration inputDecor({
  required String hintText,
  required String assetIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    errorStyle: alertTextStyle,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: subtitleTextSytle,
    prefixIcon: Padding(
      padding: const EdgeInsets.all(15),
      child: Image.asset(
        assetIcon,
        width: 17,
      ),
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 25),
    counterText: '',
    filled: true,
    fillColor: bgColor2,
  );
}

Widget customAlertDialog({
  required BuildContext context,
  required VoidCallback onpress,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - (2 * defaultMargin),
    child: AlertDialog(
      backgroundColor: bgColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: primaryTextColor,
                ),
              ),
            ),
            Image.asset(
              'assets/icon/succes_icon.png',
              width: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Edit Profile',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Successfully Changed Profile.',
              style: secondaryTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onpress,
                child: Text(
                  'Back',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget loadingDialog({
  required BuildContext context,
  required VoidCallback onpress,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - (2 * defaultMargin),
    child: AlertDialog(
      backgroundColor: bgColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Loading..',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget authAlertDialog({
  required BuildContext context,
  required String message,
  required IconData icon,
  bool multipleButton = false,
  String titleText = 'Attention',
  VoidCallback? onpress,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - (2 * defaultMargin),
    child: AlertDialog(
      backgroundColor: bgColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: primaryTextColor,
                ),
              ),
            ),
            Icon(
              icon,
              color: const Color(0xff38ABBE),
              size: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              titleText,
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              message,
              style: secondaryTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (multipleButton)
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: subtitleTextColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                if (multipleButton) const Spacer(),
                SizedBox(
                  width: 100,
                  height: 44,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: multipleButton
                        ? onpress
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: Text(
                      'Ok',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
