import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/providers/message.provider.dart';
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
              Provider.of<MessageProvider>(context, listen: false)
                  .controller
                  .clear();
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
                    'Tokopaedi',
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
            Consumer<MessageProvider>(
              builder: (context, data, _) => Row(
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
                          controller: data.controller,
                          style: primaryTextStyle,
                          decoration: InputDecoration.collapsed(
                            hintText: 'type something..',
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
                    onTap: !data.isActive
                        ? null
                        : () {
                            Provider.of<MessageProvider>(context, listen: false)
                                .addMessage(
                              context: context,
                              productModel: widget.productModel,
                            );
                            if (widget.productModel != null) {
                              setState(() {
                                widget.productModel = null;
                              });
                            }
                          },
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
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Provider.of<MessageProvider>(context, listen: false)
                  .getMessage(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: Text(
                            'Memuat...',
                            style: subtitleTextSytle,
                          ),
                        )
                      : snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => ChatBubble(
                                hasProduct: snapshot.data!.docs[index]
                                    ['product'],
                                text: snapshot.data!.docs[index]['message'],
                                isSender: snapshot.data!.docs[index]
                                    ['isFromUser'],
                              ),
                            )
                          : Center(
                              child: Text(
                                'Please start send message...',
                                style: subtitleTextSytle,
                              ),
                            ),
            ),
          ),
          chatInput(),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Provider.of<MessageProvider>(context, listen: false).controller.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: bgColor3,
        appBar: detailChatAppBar(),
        body: content(),
      ),
    );
  }
}
