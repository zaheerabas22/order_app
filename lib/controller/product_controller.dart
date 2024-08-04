import 'dart:developer';

import 'package:get/get.dart';
import 'package:order_app/models/product_response.dart';
import 'package:order_app/repository/respository.dart';

class ProductController extends GetxController{
  static ProductController instance = Get.find();
RxList products = <ProductResponse>[].obs;
RxBool isLoading = true.obs;
final apiRepository= Respository();


void fetchProductList(){
  isLoading(true);
  apiRepository.getProductList().then((value){

    log(value.products.toString());
    isLoading(false);
    products.value=value as List;
  }).onError((error, stackTrace){
  isLoading(false);
  });


}

@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchProductList();
  }





}