
import 'package:order_app/models/product_response.dart';
import 'package:order_app/network/network_api_service.dart';

class Respository{
  static const String apiUrl = 'https://app.giotheapp.com/api-sample/';
Future<ProductResponse> getProductList() async{
    final apiServices= NetworkApiService();
  final response = await apiServices.get(apiUrl);
  final productResponse = ProductResponse.fromJson(response);
  return productResponse;
} 

}