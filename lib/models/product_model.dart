//created constructer for products

class Product {
  String name;
  int quantity;
  String? notes;
  String? imagePath;

  Product({
    required this.name,
    required this.quantity,
    this.notes,
    this.imagePath,
  });
}
