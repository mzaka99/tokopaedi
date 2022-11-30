import 'package:flutter/cupertino.dart';
import '../models/category_model.dart';
import '../services/api_services.dart';

class CategoryProductProvider with ChangeNotifier {
  bool isLoading = true;
  String categoryId = 'cp0';

  List<CategoryProductModel> _dataCategoryProduct = [];
  List<CategoryProductModel> get dataCategoryProduct {
    return [..._dataCategoryProduct];
  }

  CategoryProductModel selectCategory(String id) {
    return dataCategoryProduct.firstWhere((data) => data.id == id);
  }

  void changesCategory(String categoriesId) {
    categoryId = categoriesId;
    notifyListeners();
  }

  Future<void> fetchDataCategoryProduct() async {
    try {
      isLoading = true;
      final getData = await APIServices().getData(path: '/categoryProduct.json')
          as Map<String, dynamic>;
      final List<CategoryProductModel> loadedData = [];
      getData.forEach((prodId, prodData) {
        loadedData.add(
          CategoryProductModel(
            id: prodId,
            name: prodData,
          ),
        );
      });
      _dataCategoryProduct = loadedData;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
