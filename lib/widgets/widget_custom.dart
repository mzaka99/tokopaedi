import 'package:flutter/cupertino.dart';
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

InputDecoration inputDecor({
  required String hintText,
  required String assetIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: EdgeInsets.only(left: 10, top: 13, bottom: 13),
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

Widget authAlertDialog({
  required BuildContext context,
  required String message,
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
