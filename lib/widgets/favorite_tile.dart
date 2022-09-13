import 'package:flutter/material.dart';
import 'package:tokopaedi/theme.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              'assets/shoes/preview_shoes.png',
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
                  'Shoe Store',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  '\$143.98',
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
    );
  }
}
