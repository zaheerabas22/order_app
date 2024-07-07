
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:order_app/exceptions/app_exceptions.dart';
import 'package:order_app/network/base_api_response.dart';

class NetworkApiService extends BaseApiServices{
  @override
  Future get(String url) async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url),).timeout(const Duration(seconds: 30));
      responseJson = _returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}
  