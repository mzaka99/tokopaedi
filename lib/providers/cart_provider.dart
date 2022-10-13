import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokopaedi/models/cart_model.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/providers/fcm_provider.dart';

class CartProvider with ChangeNotifier {
  late final Map<String, CartModel> _cartItem = {};
  bool isLoading = false;
  Map<String, CartModel> get cartItem {
    return {..._cartItem};
  }

  double get totalPrice {
    var total = 0.0;
    _cartItem.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get totalProduct {
    int total = 0;
    _cartItem.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  void addCartItem(ProductModel product) {
    if (_cartItem.containsKey(product.id)) {
      _cartItem.update(
        product.id,
        (existData) => CartModel(
          id: existData.id,
          nameProduct: existData.nameProduct,
          quantity: existData.quantity + 1,
          price: existData.price,
          imageUrl: existData.imageUrl,
        ),
      );
    } else {
      _cartItem.putIfAbsent(
        product.id,
        () => CartModel(
          id: DateTime.now().toString(),
          nameProduct: product.name,
          quantity: 1,
          price: product.price,
          imageUrl: product.imageUrl[0].url,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartItem.containsKey(productId)) {
      return;
    }
    if (_cartItem[productId]!.quantity > 1) {
      _cartItem.update(
        productId,
        (existData) => CartModel(
          id: existData.id,
          nameProduct: existData.nameProduct,
          quantity: existData.quantity - 1,
          price: existData.price,
          imageUrl: existData.imageUrl,
        ),
      );
    } else {
      _cartItem.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clear() {
    _cartItem.clear();
    notifyListeners();
  }

  Future<void> addOrder(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('orders').add({
      'orderId': Timestamp.now(),
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'total_price': totalPrice,
      'total_product': totalProduct,
      'product': cartItem.values
          .toList()
          .map((data) => {
                'product_id': data.id,
                'name': data.nameProduct,
                'price': data.price,
                'image_url': data.imageUrl,
                'quantity': data.quantity,
              })
          .toList(),
      'status': 'ON_PROGRESS',
    }).then((value) {
      clear();
      Provider.of<FCMProvider>(context, listen: false).showNotification();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(
            '/checkout-success',
            (route) => false,
          )
          .then(
            (_) => clear(),
          );
    });
    isLoading = false;
    notifyListeners();
  }
}
