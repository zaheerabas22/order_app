import 'package:get/get.dart';
import 'package:order_app/models/product_model.dart';

class OrderScreenController extends GetxController {
  RxBool isDataEntered = false.obs;

  void checkDataEntered(List<Product> products) {
    bool hasData = products.any(
        (product) => product.quantity.isNotEmpty && product.name.isNotEmpty);
    isDataEntered.value = hasData;
  }
}
