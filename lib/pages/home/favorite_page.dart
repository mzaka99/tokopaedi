import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/favorite_provider.dart';
import 'package:tokopaedi/widgets/favorite_tile.dart';

import '../../theme.dart';

class FavoritePage extends StatelessWidget {
  final Function(int index) changeIndexFn;
  const FavoritePage({Key? key, required this.changeIndexFn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          'Favorite Shoes',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget emptyFav() {
      return Container(
          color: bgColor3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/fav_icon.png',
                color: const Color(0xff38ABBE),
                width: 74,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' You don\'t have dream shoes?',
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
                      changeIndexFn(0);
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
          ));
    }

    Widget content() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.zero,
          color: bgColor3,
          child: Consumer<FavoriteProvider>(
            builder: (context, data, _) => data.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : data.favProductList.isEmpty
                    ? emptyFav()
                    : ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        itemCount: data.favProductList.length,
                        itemBuilder: (context, index) => FavoriteTile(
                          product: data.favProductList[index],
                        ),
                      ),
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
