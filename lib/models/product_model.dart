class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final int categoriesId;
  final String imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
    required this.imageUrl,
  });
}
