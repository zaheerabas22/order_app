class Product {
  String quantity;
  String name;
  String note;
  String imagePath;

  Product({
    required this.quantity,
    required this.name,
    this.note = '',
    this.imagePath = '',
  });
}
