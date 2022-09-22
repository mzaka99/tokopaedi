import 'package:flutter/foundation.dart';
import 'package:tokopaedi/models/cart_model.dart';
import 'package:tokopaedi/models/product_model.dart';

class CartProvider with ChangeNotifier {
  late final Map<int, CartModel> _cartItem = {};
  Map<int, CartModel> get cartItem {
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
          imageUrl: product.imageUrl,
        ),
      );
    }

    notifyListeners();
  }

  void removeSingleItem(int productId) {
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

  void removeItem(int productId) {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clear() {
    _cartItem.clear();
    notifyListeners();
  }
}
