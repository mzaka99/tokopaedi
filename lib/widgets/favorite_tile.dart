import 'package:flutter/material.dart';
import 'package:tokopaedi/models/favorite_product_model.dart';
import 'package:tokopaedi/theme.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final FavoriteProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/product',
          arguments: product.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 12,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor4,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                width: 60,
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
                    product.name,
                    maxLines: 1,
                    style: primaryTextStyle.copyWith(
                        fontWeight: semiBold, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    '\$${product.price}',
                    maxLines: 1,
                    style: priceTextStyle,
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/icon/button_fav_blue.png',
              width: 34,
            ),
          ],
        ),
      ),
    );
  }
}
