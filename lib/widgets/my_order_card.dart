import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/my_order_model.dart';
import 'package:tokopaedi/providers/my_order_provider.dart';
import 'package:tokopaedi/theme.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    Key? key,
    required this.cart,
    required this.docId,
  }) : super(key: key);
  final String docId;
  final MyOrderModel cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      color: bgColor4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        cart.products[0].imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.products[0].nameProduct,
                        style: primaryTextStyle.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '\$${cart.products[0].price}',
                        style: priceTextStyle,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${cart.products[0].quantity}x',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            thickness: 0.2,
            color: subtitleTextColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cart.totalProduct} prdouct',
                  style: secondaryTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total : ',
                      style: primaryTextStyle,
                    ),
                    Text('\$${cart.totalPrice}', style: priceTextStyle),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 0.2,
            color: subtitleTextColor,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: SizedBox(
                width: 150,
                height: 40,
                child: TextButton(
                  onPressed: cart.status == 'ON_PROGRESS'
                      ? () {
                          Provider.of<MyOrderProvider>(context, listen: false)
                              .receiveOrder(context, docId);
                        }
                      : null,
                  style: TextButton.styleFrom(
                      backgroundColor: cart.status == 'ON_PROGRESS'
                          ? primaryColor
                          : secondaryTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    cart.status == 'ON_PROGRESS' ? 'Accept' : 'Received',
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
