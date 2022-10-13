import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tokopaedi/theme.dart';

class CheckoutSuccesPage extends StatelessWidget {
  const CheckoutSuccesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          'Checkout Success',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget emptyChat() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/succes_icon.png',
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your transaction was successful',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: 190,
              child: Text(
                'Stay at home while we prepare your dream shoes',
                style: secondaryTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 44,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home',
                    (route) => false,
                  );
                },
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
                  'Order Other Shoes',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 44,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .restorablePushNamed('/home', arguments: 3);
                  Navigator.of(context).pushNamed(
                    '/my-orders',
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  backgroundColor: const Color(0xff39374B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: Text(
                  'View My Order',
                  style: GoogleFonts.poppins(
                    color: const Color(
                      0xffB7B6BF,
                    ),
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

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: emptyChat(),
    );
  }
}
