import 'package:get/get.dart';
import 'package:order_app/models/product_model.dart';

class OrderController extends GetxController {
  var products = <Product>[].obs;
  var isButtonEnabled = false.obs;

  void addProduct(Product product) {
    products.add(product);
    _updateButtonState();
  }

  void updateProduct(int index, Product product) {
    products[index] = product;
    _updateButtonState();
  }

  void removeProduct(int index) {
    products.removeAt(index);
    _updateButtonState();
  }

  void _updateButtonState() {
    isButtonEnabled.value = products.isNotEmpty;
  }
}