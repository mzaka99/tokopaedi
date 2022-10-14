import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/theme.dart';
import 'package:tokopaedi/widgets/chat_tile.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

import '../../providers/message.provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: Text(
          'Message Support',
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
      return StreamBuilder(
        stream:
            Provider.of<MessageProvider>(context, listen: false).getMessage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                child: Text(
                  'Memuat...',
                  style: subtitleTextSytle,
                ),
              ),
            );
          } else if (snapshot.data!.docs.isNotEmpty) {
            return Expanded(
              child: Container(
                width: double.infinity,
                color: bgColor3,
                child: ListView.builder(
                    itemCount: 1,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.parse(snapshot
                          .data!.docs[index]['createdAt']
                          .toDate()
                          .toString());
                      return ChatTile(
                        message: snapshot.data!.docs[0]['message'],
                        dateTime: date,
                      );
                    }),
              ),
            );
          } else {
            return Expanded(
              child: emptyContent(
                  assetIcon: 'assets/icon/headset_icon.png',
                  title: 'Opss no message yet?',
                  subtitle: 'You have never done a transaction',
                  withButton: false),
            );
          }
        },
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
