import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/cart_model.dart';
import 'package:tokopaedi/providers/cart_provider.dart';
import 'package:tokopaedi/theme.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataCart = Provider.of<CartProvider>(context, listen: false);
    return Container(
      height: dataCart.cartItem.length > 3
          ? 350
          : 85 * dataCart.cartItem.length.toDouble(),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      child: Scrollbar(
        thickness: 1,
        child: ListView.builder(
          itemCount: dataCart.cartItem.length,
          itemBuilder: (context, index) => listItem(
            dataCart.cartItem.values.toList()[index],
          ),
        ),
      ),
    );
  }

  Widget listItem(CartModel cartItem) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(cartItem.imageUrl),
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
                    cartItem.nameProduct,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  Text('\$${cartItem.price}', style: priceTextStyle),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${cartItem.quantity} Items',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
              ),
            )
          ],
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff2E3141),
        ),
      ],
    );
  }
}
