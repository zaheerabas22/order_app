import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/models/product_model.dart';

class RowFocusController extends GetxController {
  var validProductsList = <Product>[].obs;
  var focusNodes = <FocusNode>[].obs;

  @override
  void onInit() {
    super.onInit();
    _addInitialRows();
    _focusOnFirstEmptyRow();
  }

  void _addInitialRows() {
    for (int i = 0; i < 10; i++) {
      validProductsList.add(Product(quantity: '', name: ''));
      focusNodes.add(FocusNode());
    }
  }

  void addRow() {
    validProductsList.add(Product(quantity: '', name: ''));
    focusNodes.add(FocusNode());
    _focusOnFirstEmptyRow();
  }

  void _focusOnFirstEmptyRow() {
    for (int i = 0; i < validProductsList.length; i++) {
      if (validProductsList[i].name.isEmpty && validProductsList[i].quantity.isEmpty) {
        focusNodes[i].requestFocus();
        break;
      }
    }
  }

  void disposeFocusNodes() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
  }

  bool isDataEntered() {
    return validProductsList.any(
        (product) => product.name.isNotEmpty || product.quantity.isNotEmpty);
  }
}
