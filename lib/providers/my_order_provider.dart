import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/providers/fcm_provider.dart';
import 'package:tokopaedi/widgets/widget_custom.dart';

class MyOrderProvider with ChangeNotifier {
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
    showDialog(
      context: context,
      builder: (context) {
        return loadingDialog(context: context, onpress: () {});
      },
    );
    await orders.doc(docId).update({
      'status': 'RECEIVED',
    }).whenComplete(() {
      Navigator.of(context).pop();
    }).then(
      (_) => Provider.of<FCMProvider>(context, listen: false)
          .showNotification(isOrder: false),
    );
  }
}
