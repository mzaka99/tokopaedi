import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/cart_model.dart';
import 'package:tokopaedi/providers/cart_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/theme.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.productId,
  }) : super(key: key);
  final int productId;
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .selectProduct(productId);
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      cart.imageUrl,
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
                      cart.nameProduct,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '\$${cart.price}',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCartItem(product);
                    },
                    child: Image.asset(
                      'assets/icon/button_add.png',
                      width: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    cart.quantity.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeSingleItem(productId);
                    },
                    child: Image.asset(
                      'assets/icon/button_min.png',
                      width: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false)
                  .removeItem(productId);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icon/trash_icon.png',
                  width: 10,
                  height: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Remove',
                  style: alertTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
