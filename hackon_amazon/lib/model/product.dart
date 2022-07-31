class Product {
  final int id;
  final String name;
  final String subtext;
  final List imgUrl;
  final String? oldPrice;
  final String price;
  final String? discount;
  final bool liked;
  final String? tag;
  final int itemCount;

  Product(
      {required this.id,
      required this.name,
      required this.subtext,
      required this.imgUrl,
      this.oldPrice,
      required this.price,
      this.discount,
      required this.liked,
      this.tag,
      required this.itemCount});
}
