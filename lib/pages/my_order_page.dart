import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/widgets/my_order_card.dart';

import '../providers/cart_provider.dart';
import '../theme.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

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
          'Your Orders',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/icon_cart_empty.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Opss! Your Cart is Empty',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle,
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
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  )),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: bgColor1,
                child: TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  indicatorColor: primaryColor,
                  labelStyle: primaryTextStyle,
                  unselectedLabelStyle: primaryTextStyle,
                  tabs: const [
                    Tab(
                      text: 'On Progress',
                    ),
                    Tab(
                      text: 'Received',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Consumer<CartProvider>(
                      builder: (context, data, _) => data.cartItem.isEmpty
                          ? emptyCart()
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: data.cartItem.length,
                                    itemBuilder: (context, index) =>
                                        MyOrderCard(
                                      productId:
                                          data.cartItem.keys.toList()[index],
                                      cart:
                                          data.cartItem.values.toList()[index],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
