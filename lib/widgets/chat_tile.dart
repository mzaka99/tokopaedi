import 'package:flutter/material.dart';
import 'package:tokopaedi/pages/detail_chat_page.dart';
import 'package:tokopaedi/theme.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, required this.message, required this.dateTime})
      : super(key: key);
  final String message;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailChatPage(productModel: null),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icon/logo_shop_icon.png',
                  width: 54,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tokopaedi',
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        message,
                        maxLines: 1,
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('hh:mm').format(dateTime) ==
                          DateFormat('hh:mm').format(DateTime.now())
                      ? 'Now'
                      : DateFormat('dd/MM/yyyy').format(dateTime) ==
                              DateFormat('dd/MM/yyyy').format(DateTime.now())
                          ? DateFormat('hh:mm').format(dateTime)
                          : DateFormat('dd/MM/yyyy').format(dateTime),
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            )
          ],
        ),
      ),
    );
  }
}
