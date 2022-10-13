import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/my_order_model.dart';
import 'package:tokopaedi/providers/fcm_provider.dart';

class MyOrderProvider with ChangeNotifier {
  List<MyOrderModel> _dataOrder = [];
  List<MyOrderModel> get dataOrder {
    return [..._dataOrder];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getDataOrder(String status) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  Future<void> receiveOrder(BuildContext context, String docId) async {
    final orders = FirebaseFirestore.instance.collection('orders');

    await orders.doc(docId).update({
      'status': 'RECEIVED',
    }).then(
      (_) => Provider.of<FCMProvider>(context, listen: false)
          .showNotification(isOrder: false),
    );
  }
}
