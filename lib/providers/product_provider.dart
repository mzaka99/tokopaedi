import 'package:flutter/cupertino.dart';
import 'package:tokopaedi/models/product_model.dart';
import 'package:tokopaedi/services/api_services.dart';

class ProductProvider with ChangeNotifier {
  String categoriesId = 'cp0';
  int currentIndexImage = 0;
  bool isLoading = true;

  List<ProductModel> _dataProduct = [];
  List<ProductModel> get dataProduct {
    return [..._dataProduct];
  }

  ProductModel selectProduct(String id) {
    return dataProduct.firstWhere((data) => data.id == id);
  }

  List<ProductModel> getProductBy(String id) {
    return [...dataProduct.where((data) => data.categoriesId == id)];
  }

  void slideCarousel(int index) {
    currentIndexImage = index;
    notifyListeners();
  }

  void changesCategory(String categoryId) {
    categoryId = categoryId;
    notifyListeners();
  }

  Future<void> fetchDataProduct() async {
    isLoading = true;
    try {
      final getData = await APIServices().getData(path: '/products.json')
          as Map<String, dynamic>;
      final List<ProductModel> loadedData = [];
      getData.forEach((prodId, prodData) {
        loadedData.add(
          ProductModel(
            id: prodId,
            name: prodData['name'],
            price: double.parse(prodData['price']),
            description: prodData['description'],
            categoriesId: prodData['categoryId'],
            imageUrl: (prodData['image'] as List<dynamic>)
                .map((url) => ImageUrlModel(url: url['url']))
                .toList(),
          ),
        );
      });
      isLoading = false;
      _dataProduct = loadedData;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
