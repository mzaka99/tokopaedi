import 'package:flutter/cupertino.dart';
import 'package:tokopaedi/dummy_data.dart';
import 'package:tokopaedi/models/category_model.dart';
import 'package:tokopaedi/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  int id = 0;
  int currentIndexImage = 0;
  CategoryProductModel selectCategory(int id) {
    return dummyDataCategoryProduct.firstWhere((data) => data.id == id);
  }

  ProductModel selectProduct(int id) {
    return dummyDataProduct.firstWhere((data) => data.id == id);
  }

  List<ProductModel> getProductBy(int id) {
    return [...dummyDataProduct.where((data) => data.id == id)];
  }

  void slideCarousel(int index) {
    currentIndexImage = index;
    notifyListeners();
  }

  void changesCategory(int categoryId) {
    id = categoryId;
    notifyListeners();
  }
}
