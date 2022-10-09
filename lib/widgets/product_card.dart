import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/providers/category_product_provider.dart';
import 'package:tokopaedi/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

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
            CachedNetworkImage(
              imageUrl: product.imageUrl[0].url,
              placeholder: (context, url) => Shimmer(
                child: Container(
                  color: Colors.grey.shade300,
                ),
              ),
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
                  Consumer<CategoryProductProvider>(
                    builder: (context, data, child) => Text(
                      data.selectCategory(product.categoriesId).name,
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
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
                    '\$${product.price.toString()}',
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
