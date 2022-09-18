import 'package:flutter/foundation.dart';
import 'package:tokopaedi/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favProductList = [];
  List<Product> get favProductList => [..._favProductList];

  void addFavoriteProduct(Product product) {
    List<Product> isFav = [..._favProductList.where((data) => data == product)];

    if (isFav.isEmpty) {
      _favProductList.add(product);
    } else {
      _favProductList.removeWhere((data) => data == product);
    }
    notifyListeners();
  }

  bool isFavoriteProduct(int id) {
    print(id);
    List<Product> isFav = [..._favProductList.where((data) => data.id == id)];
    if (isFav.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
