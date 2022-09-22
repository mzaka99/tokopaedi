class CartModel {
  final String id;
  final String nameProduct;
  final int quantity;
  final double price;
  final String imageUrl;

  CartModel({
    required this.id,
    required this.nameProduct,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}
