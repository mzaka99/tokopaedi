import 'package:flutter/material.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/theme.dart';
import 'package:tokopaedi/widgets/chat_bubble.dart';

// ignore: must_be_immutable
class DetailChatPage extends StatefulWidget {
  ProductModel? productModel;
  DetailChatPage({
    required this.productModel,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  @override
  Widget build(BuildContext context) {
    AppBar detailChatAppBar() {
      return AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: bgColor1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            )),
        title: Row(
          children: [
            Image.asset(
              'assets/icon/logo_icon_online.png',
              width: 50,
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
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    'Online',
                    maxLines: 1,
                    style: secondaryTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget productReview() {
      return Container(
        width: 225,
        height: 74,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: bgColor5,
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.productModel!.imageUrl[0].url,
                width: 54,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel!.name,
                    style: primaryTextStyle.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    '\$${widget.productModel!.price}',
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.productModel = null;
                });
              },
              child: Image.asset(
                'assets/icon/close_button.png',
                width: 22,
              ),
            ),
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.productModel == null ? const SizedBox() : productReview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Hi, This item is still available?',
                          hintStyle: subtitleTextSytle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12.5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.send_sharp,
                      color: primaryTextColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: const [
          ChatBubble(
              hasProduct: true,
              isSender: true,
              text: 'Hello Ganhsajhsjahjshjahsjasasasjahgsjahg'),
          ChatBubble(
              isSender: false,
              text:
                  'Good night, This item is only available in size 42 and 43'),
          ChatBubble(
              isSender: true,
              text: 'Hello Ganhsajhsjahjshjahsjasasasjahgsjahg'),
          ChatBubble(
              isSender: false,
              text:
                  'Good night, This item is only available in size 42 and 43'),
          ChatBubble(
              isSender: true,
              text: 'Hello Ganhsajhsjahjshjahsjasasasjahgsjahg'),
          ChatBubble(
              isSender: false,
              text:
                  'Good night, This item is only available in size 42 and 43'),
          ChatBubble(
              isSender: true,
              text: 'Hello Ganhsajhsjahjshjahsjasasasjahgsjahg'),
          ChatBubble(
              isSender: false,
              text:
                  'Good night, This item is only available in size 42 and 43'),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: detailChatAppBar(),
      body: content(),
      bottomNavigationBar: chatInput(),
    );
  }
}
