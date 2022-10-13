import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/cart_model.dart';
import 'package:tokopaedi/models/my_order_model.dart';
import 'package:tokopaedi/providers/my_order_provider.dart';
import 'package:tokopaedi/widgets/my_order_card.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

import '../providers/cart_provider.dart';
import '../theme.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 32,
              color: primaryTextColor,
            )),
        title: Text(
          'Your Orders',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: bgColor1,
                child: TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  indicatorColor: primaryColor,
                  labelStyle: primaryTextStyle,
                  unselectedLabelStyle: primaryTextStyle,
                  tabs: const [
                    Tab(
                      text: 'On Progress',
                    ),
                    Tab(
                      text: 'Received',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          Provider.of<MyOrderProvider>(context, listen: false)
                              .getDataOrder('ON_PROGRESS'),
                      builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : snapshot.data!.docs.isEmpty
                                  ? emptyContent(
                                      assetIcon:
                                          'assets/icon/icon_cart_empty.png',
                                      title: 'No Orders Yet.',
                                      subtitle: 'Let\'s Place Order.',
                                      withButton: false,
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) =>
                                                MyOrderCard(
                                              docId:
                                                  snapshot.data!.docs[index].id,
                                              cart: MyOrderModel(
                                                  orderId: snapshot.data!
                                                      .docs[index]['orderId']
                                                      .toString(),
                                                  totalProduct:
                                                      snapshot.data!.docs[index]
                                                          ['total_product'],
                                                  totalPrice:
                                                      snapshot.data!.docs[index]
                                                          ['total_price'],
                                                  status: snapshot.data!
                                                      .docs[index]['status'],
                                                  products: (snapshot
                                                                  .data!.docs[
                                                              index]['product']
                                                          as List<dynamic>)
                                                      .map((data) => CartModel(
                                                            id: data[
                                                                'product_id'],
                                                            nameProduct:
                                                                data['name'],
                                                            quantity: data[
                                                                'quantity'],
                                                            price:
                                                                data['price'],
                                                            imageUrl: data[
                                                                'image_url'],
                                                          ))
                                                      .toList()),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          Provider.of<MyOrderProvider>(context, listen: false)
                              .getDataOrder('RECEIVED'),
                      builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : snapshot.data!.docs.isEmpty
                                  ? emptyContent(
                                      assetIcon:
                                          'assets/icon/icon_cart_empty.png',
                                      title: 'No Orders Yet.',
                                      subtitle: 'Let\'s Place Order.',
                                      withButton: false,
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) =>
                                                MyOrderCard(
                                              docId:
                                                  snapshot.data!.docs[index].id,
                                              cart: MyOrderModel(
                                                  orderId: snapshot.data!
                                                      .docs[index]['orderId']
                                                      .toString(),
                                                  totalProduct:
                                                      snapshot.data!.docs[index]
                                                          ['total_product'],
                                                  totalPrice:
                                                      snapshot.data!.docs[index]
                                                          ['total_price'],
                                                  status: snapshot.data!
                                                      .docs[index]['status'],
                                                  products: (snapshot
                                                                  .data!.docs[
                                                              index]['product']
                                                          as List<dynamic>)
                                                      .map((data) => CartModel(
                                                            id: data[
                                                                'product_id'],
                                                            nameProduct:
                                                                data['name'],
                                                            quantity: data[
                                                                'quantity'],
                                                            price:
                                                                data['price'],
                                                            imageUrl: data[
                                                                'image_url'],
                                                          ))
                                                      .toList()),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
