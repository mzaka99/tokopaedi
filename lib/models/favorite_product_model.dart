class FavoriteProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String categoriesId;
  final String imageUrl;

  FavoriteProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
    required this.imageUrl,
  });
}
