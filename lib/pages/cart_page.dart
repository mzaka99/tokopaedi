import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/cart_provider.dart';
import 'package:tokopaedi/widgets/cart_card.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

import '../theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 32,
              color: primaryTextColor,
            )),
        title: Text(
          'Your Cart',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
      );
    }

    Widget customButtonNav(double totalPrice) {
      return SizedBox(
        height: 160,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\$${totalPrice.toString()}',
                    style: priceTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.2,
              color: subtitleTextColor,
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/checkout');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continue to Checkout',
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: primaryTextColor,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }

    final args = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: Consumer<CartProvider>(
        builder: (context, data, _) => data.cartItem.isEmpty
            ? emptyContent(
                assetIcon: 'assets/icon/icon_cart_empty.png',
                title: 'Opss! Your Cart is Empty',
                subtitle: 'Let\'s find your favorite shoes',
                onpress: args != null
                    ? () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    : () {
                        Navigator.of(context).pop();
                      })
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: Text(
                      '*the products in the cart will be lost if you close the app.',
                      style: subtitleTextSytle.copyWith(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      itemCount: data.cartItem.length,
                      itemBuilder: (context, index) => CartCard(
                        productId: data.cartItem.keys.toList()[index],
                        cart: data.cartItem.values.toList()[index],
                      ),
                    ),
                  ),
                  customButtonNav(data.totalPrice),
                ],
              ),
      ),
    );
  }
}
