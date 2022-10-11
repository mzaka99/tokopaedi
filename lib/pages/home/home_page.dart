import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tokopaedi/providers/category_product_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/providers/user_provider.dart';
import 'package:tokopaedi/theme.dart';
import 'package:tokopaedi/widgets/product_card.dart';
import 'package:tokopaedi/widgets/product_tile.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header({
      required String fullname,
      required String username,
      required String imgurl,
    }) {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Consumer<UserProvider>(
          builder: (context, data, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hallo, $fullname",
                      maxLines: 1,
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '@$username',
                      style: subtitleTextSytle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              imgurl == ''
                  ? const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/icon/profile_icon.png'),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: imgurl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer(
                          child: Container(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    }

    Widget categories() {
      return Container(
        height: 40,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Consumer<CategoryProductProvider>(
          builder: (context, data, _) => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  data.changesCategory(
                    data.dataCategoryProduct[index].id,
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
                    color: data.categoryId == data.dataCategoryProduct[index].id
                        ? primaryColor
                        : transparentColor,
                    border:
                        data.categoryId == data.dataCategoryProduct[index].id
                            ? null
                            : Border.all(
                                color: subtitleTextColor,
                              ),
                  ),
                  child: Text(
                    data.dataCategoryProduct[index].name,
                    style: data.categoryId == data.dataCategoryProduct[index].id
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
            itemCount: data.dataCategoryProduct.length,
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

    Widget popularProduct(String categoriesId) {
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
              product: categoriesId == 'cp0'
                  ? data.dataProduct[index]
                  : data.getProductBy(categoriesId)[index],
            ),
            itemCount: categoriesId == 'cp0'
                ? data.dataProduct.length
                : data.getProductBy(categoriesId).length,
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

    Widget newArrival(String categoriesId) {
      return Consumer<ProductProvider>(
        builder: (context, data, _) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ProductTile(
              product: categoriesId == 'cp0'
                  ? data.dataProduct[index]
                  : data.getProductBy(categoriesId)[index],
            ),
          ),
          itemCount: categoriesId == 'cp0'
              ? data.dataProduct.length
              : data.getProductBy(categoriesId).length,
        ),
      );
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => Provider.of<ProductProvider>(context, listen: false)
            .fetchDataProduct(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer3<UserProvider, CategoryProductProvider, ProductProvider>(
                builder: (contex, dataUser, dataCategory, dataProduct, _) =>
                    dataProduct.isLoading ||
                            dataCategory.isLoading ||
                            dataUser.loadDataUser
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height -
                                defaultMargin,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Column(
                            children: [
                              header(
                                fullname: dataUser.dataUser!.fullName,
                                username: dataUser.dataUser!.userName,
                                imgurl: dataUser.dataUser!.imageUrl!,
                              ),
                              categories(),
                              dataCategory.categoryId != 'cp0' &&
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .getProductBy(dataCategory.categoryId)
                                          .isEmpty
                                  ? emptyContent(
                                      assetIcon:
                                          'assets/icon/icon_cart_empty.png',
                                      title: 'Sorry, the shoes doesn\'t exist',
                                      subtitle: 'Let\'s find other shoes',
                                      withButton: false,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        popularProductTitle(),
                                        popularProduct(dataCategory.categoryId),
                                        newArrivalTitle(),
                                        newArrival(dataCategory.categoryId),
                                      ],
                                    ),
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
