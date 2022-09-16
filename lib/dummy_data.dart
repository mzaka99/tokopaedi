import 'package:tokopaedi/models/category_model.dart';
import 'package:tokopaedi/models/product_model.dart';

const dummyDataProduct = [
  Product(
    id: 1,
    name: 'Ultra 4D 5 Shoes',
    price: 54.12,
    description:
        'When the adidas Ultraboost debuted backin 2015, it had an impact that spilled beyondthe world of running. For this version of t...',
    categoriesId: 1,
    imageUrl: 'assets/shoes/preview_shoes.png',
  ),
  Product(
    id: 2,
    name: 'SL 20 Shoes',
    price: 94.12,
    description:
        'These adidas SL20 Shoes will back your play. Lightweight cushioning gives you a faster push-off and a snappy feel.',
    categoriesId: 2,
    imageUrl: 'assets/shoes/preview_shoes2.png',
  ),
  Product(
    id: 3,
    name: 'Ultraboots 20 Shoes',
    price: 24.12,
    description:
        'Wear your values on your feet with these adidas running shoes. Rocking the wild colours shows you\'re not shy about standing out.',
    categoriesId: 3,
    imageUrl: 'assets/shoes/preview_shoes3.png',
  ),
];

const dummyDataCategoryProduct = [
  CategoryProduct(
    id: 0,
    name: 'All Shoes',
  ),
  CategoryProduct(
    id: 1,
    name: 'Running',
  ),
  CategoryProduct(
    id: 2,
    name: 'Training',
  ),
  CategoryProduct(
    id: 3,
    name: 'BasketBall',
  ),
  CategoryProduct(
    id: 4,
    name: 'Hiking',
  ),
];
