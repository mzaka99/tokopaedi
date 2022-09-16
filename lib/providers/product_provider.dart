import 'package:flutter/cupertino.dart';
import 'package:tokopaedi/dummy_data.dart';
import 'package:tokopaedi/models/category_model.dart';
import 'package:tokopaedi/models/product_model.dart';

class ProductList with ChangeNotifier {
  int id = 0;
  CategoryProduct selectCategory(int id) {
    return dummyDataCategoryProduct.firstWhere((data) => data.id == id);
  }

  Product selectProduct(int id) {
    return dummyDataProduct.firstWhere((data) => data.id == id);
  }

  List<Product> getProductBy(int id) {
    return [...dummyDataProduct.where((data) => data.id == id)];
  }

  void changesCategory(int categoryId) {
    id = categoryId;
    notifyListeners();
    print(id);
  }
}
