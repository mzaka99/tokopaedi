import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/dummy_data.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/theme.dart';
import 'package:tokopaedi/widgets/product_card.dart';
import 'package:tokopaedi/widgets/product_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, Alex',
                    maxLines: 1,
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@alexkeinn',
                    style: subtitleTextSytle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icon/profile_icon.png',
                    ),
                  )),
            )
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        height: 40,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Consumer<ProductProvider>(
          builder: (context, data, _) => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  data.changesCategory(
                    index,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: index == data.id ? primaryColor : transparentColor,
                    border: index == data.id
                        ? null
                        : Border.all(
                            color: subtitleTextColor,
                          ),
                  ),
                  child: Text(
                    dummyDataCategoryProduct[index].name,
                    style: index == data.id
                        ? primaryTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                          )
                        : subtitleTextSytle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                          ),
                  ),
                ),
              );
            },
            itemCount: dummyDataCategoryProduct.length,
          ),
        ),
      );
    }

    Widget popularProductTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Product',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProduct() {
      return Container(
        height: 278,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 14,
          left: defaultMargin,
        ),
        child: Consumer<ProductProvider>(
          builder: (context, data, _) => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ProductCard(
              product: data.id == 0
                  ? dummyDataProduct[index]
                  : data.getProductBy(data.id)[index],
            ),
            itemCount: data.id == 0
                ? dummyDataProduct.length
                : data.getProductBy(data.id).length,
          ),
        ),
      );
    }

    Widget newArrivalTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'New Arrival',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrival() {
      return Consumer<ProductProvider>(
        builder: (context, data, _) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ProductTile(
              product: data.id == 0
                  ? dummyDataProduct[index]
                  : data.getProductBy(data.id)[index],
            ),
          ),
          itemCount: data.id == 0
              ? dummyDataProduct.length
              : data.getProductBy(data.id).length,
        ),
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/icon/icon_cart_empty.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Sorry, the shoes doesn\'t exist',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Let\'s find other shoes',
              style: secondaryTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            categories(),
            Consumer<ProductProvider>(
              builder: (context, data, _) =>
                  data.id != 0 && data.getProductBy(data.id).isEmpty
                      ? emptyCart()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            popularProductTitle(),
                            popularProduct(),
                            newArrivalTitle(),
                            newArrival(),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
