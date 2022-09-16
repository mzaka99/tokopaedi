import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.imageUrl,
  }) : super(key: key);
  final int id;
  final String name;
  final double price;
  final int categoryId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/product',
          arguments: id,
        );
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(right: defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffECEDEF),
        ),
        child: Column(
          children: [
            SizedBox(
              height: defaultMargin,
            ),
            Image.asset(
              imageUrl,
              width: 215,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ProductList>(
                    builder: (context, data, child) => Text(
                      data.selectCategory(categoryId).name,
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    name,
                    maxLines: 1,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '\$${price.toString()}',
                    maxLines: 1,
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
