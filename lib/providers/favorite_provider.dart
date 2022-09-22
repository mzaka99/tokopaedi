import 'package:flutter/foundation.dart';
import 'package:tokopaedi/helpers/local_db_helper.dart';
import 'package:tokopaedi/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel>? _favProductList = [];
  List<ProductModel> get favProductList => [..._favProductList!];

  Future<void> fetchFavoriteList() async {
    isLoading = true;
    List dataList = await LocalDBHelper.getData('favorite_list');
    if (dataList.isEmpty) {
      _favProductList = [];
    } else {
      _favProductList = dataList
          .map(
            (data) => ProductModel(
              id: data['id'],
              name: data['name'],
              price: data['price'],
              description: data['description'],
              categoriesId: data['categories_id'],
              imageUrl: data['image_url'],
            ),
          )
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addFavoriteProduct(ProductModel product) async {
    bool statusProduct = isFavoriteProduct(product.id);
    if (statusProduct) {
      _favProductList!.removeWhere((data) => data.id == product.id);
      LocalDBHelper.remove('favorite_list', product.id);
    } else {
      _favProductList!.add(product);
      LocalDBHelper.insert('favorite_list', {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'categories_id': product.categoriesId,
        'image_url': product.imageUrl
      });
    }
    notifyListeners();
  }

  bool isFavoriteProduct(int id) {
    List<ProductModel> isFav = [
      ..._favProductList!.where((data) => data.id == id)
    ];
    if (isFav.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
