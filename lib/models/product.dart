class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String brand;
  final String productCategoryName;
  final int quantity;
  final bool isFavourite;
  final bool isPopular;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.brand,
      required this.productCategoryName,
      required this.quantity,
      required this.isFavourite,
      required this.isPopular});
}
