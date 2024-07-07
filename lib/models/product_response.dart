class ProductResponse {
  late Map<String, String> products;

  ProductResponse({required this.products});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    products = json.map((key, value) => MapEntry(key, value.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data.addAll(products);
    return data;
  }
}

