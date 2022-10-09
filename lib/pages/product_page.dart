import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/pages/detail_chat_page.dart';
import 'package:tokopaedi/providers/cart_provider.dart';
import 'package:tokopaedi/providers/favorite_provider.dart';
import 'package:tokopaedi/providers/product_provider.dart';
import 'package:tokopaedi/theme.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List images(String url) => [
        url,
        url,
        url,
      ];

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    Future<void> showSuccesDialog() async {
      return showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - (2 * defaultMargin),
            child: AlertDialog(
              backgroundColor: bgColor3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultMargin),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/icon/succes_icon.png',
                      width: 100,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Hurray :)',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Item added successfully',
                      style: secondaryTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 154,
                      height: 44,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                            '/cart',
                          );
                        },
                        child: Text(
                          'View My Cart',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    Widget indicator(int index) {
      return Consumer<ProductProvider>(
        builder: (context, data, _) => Container(
          width: data.currentIndexImage == index ? 16 : 4,
          height: 4,
          margin: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: data.currentIndexImage == index
                ? primaryColor
                : const Color(0xffC4C4C4),
          ),
        ),
      );
    }

    Widget header(List<ImageUrlModel> urlImages) {
      int index = -1;
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.chevron_left_sharp),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    color: bgColor1,
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: urlImages
                .map((data) => Image.network(
                      data.url,
                      width: MediaQuery.of(context).size.width,
                      height: 310,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                Provider.of<ProductProvider>(context, listen: false)
                    .slideCarousel(index);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: urlImages.map((data) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget familiarShoesCard(String image) {
      return Container(
        width: 54,
        height: 54,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget content(ProductModel products) {
      ProductModel product = products;
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 17,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: bgColor1,
        ),
        child: Column(
          children: [
            //NOTE HEADER
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          'Hiking',
                          style: subtitleTextSytle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, data, _) => GestureDetector(
                      onTap: () {
                        data.addFavoriteProduct(product);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        if (data.isFavoriteProduct(product.id)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 200),
                              backgroundColor: secondaryColor,
                              content: Text(
                                'Has been added to the Wishlist',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 200),
                              backgroundColor: alertColor,
                              content: Text(
                                'Has been removed from the Wishlist',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: Image.asset(
                        data.isFavoriteProduct(product.id)
                            ? 'assets/icon/button_fav_blue.png'
                            : 'assets/icon/fav_button.png',
                        width: 46,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //NOTE: PRICE

            Container(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              decoration: BoxDecoration(
                color: bgColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price starts from',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\$${product.price}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),

            //NOTE: DESCRIPTION

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    product.description,
                    style: subtitleTextSytle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),

            //NOTE: FAMILIAR SHOES

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: defaultMargin, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Text(
                      'Fimiliar Shoes',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Consumer<ProductProvider>(builder: (context, data, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          data.dataProduct.length,
                          (index) => Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? defaultMargin : 0),
                            child: familiarShoesCard(
                              data.dataProduct[index].imageUrl[0].url,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget button(ProductModel product) {
      return Container(
        width: double.infinity,
        color: bgColor1,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailChatPage(productModel: product)));
              },
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon/button_chat.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                height: 54,
                child: TextButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addCartItem(product);
                    showSuccesDialog();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    'Add to Cart',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productData = Provider.of<ProductProvider>(context, listen: false)
        .selectProduct(productId);
    return Scaffold(
      backgroundColor: bgColor6,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                header(productData.imageUrl),
                content(productData),
              ],
            ),
          ),
          button(productData),
        ],
      ),
    );
  }
}
