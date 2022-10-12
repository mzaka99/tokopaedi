import 'package:tokopaedi/models/cart_model.dart';

class MyOrderModel {
  final String orderId;
  final int totalProduct;
  final double totalPrice;
  final String status;
  final List<CartModel> products;
  MyOrderModel({
    required this.orderId,
    required this.totalProduct,
    required this.totalPrice,
    required this.status,
    required this.products,
  });
}
