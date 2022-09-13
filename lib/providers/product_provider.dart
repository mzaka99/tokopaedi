import 'package:flutter/cupertino.dart';
import 'package:tokopaedi/dummy_data.dart';
import 'package:tokopaedi/models/category_model.dart';

class ProductList with ChangeNotifier {
  CategoryProduct selectCategory(int id) {
    return dummyDataCategoryProduct.firstWhere((data) => data.id == id);
  }
}
