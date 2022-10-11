import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/favorite_provider.dart';
import 'package:tokopaedi/widgets/favorite_tile.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

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
                    ? emptyContent(
                        assetIcon: 'assets/icon/fav_icon_blue.png',
                        title: 'You don\'t have dream shoes?',
                        subtitle: 'Let\'s find your favorite shoes',
                        onpress: () {
                          changeIndexFn(0);
                        },
                      )
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
