class ProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String categoriesId;
  final List<ImageUrlModel> imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
    required this.imageUrl,
  });
}

class ImageUrlModel {
  final String url;
  ImageUrlModel({
    required this.url,
  });
}
