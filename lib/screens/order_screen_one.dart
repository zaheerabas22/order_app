import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_app_bar.dart';
import 'package:order_app/constants/colors.dart';
import 'package:order_app/controller/image_note_controller.dart';
import 'package:order_app/models/product_list.dart';
import 'package:order_app/models/product_model.dart';
import 'package:order_app/screens/order_screen_typed.dart';

class OrderScreenNoTyped extends StatefulWidget {
  const OrderScreenNoTyped({super.key});

  @override
  OrderScreenNoTypedState createState() => OrderScreenNoTypedState();
}

class OrderScreenNoTypedState extends State<OrderScreenNoTyped> {
  final ImageNoteController controller = Get.put(ImageNoteController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _orderNumberController =
      TextEditingController(text: '11206');

  List<FocusNode> quantityFocusNodes = [];
  List<FocusNode> nameFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _addInitialRows();
  }

  void _addInitialRows() {
    for (int i = 0; i < 10; i++) {
      controller.addProduct(Product(quantity: '', name: ''));
      quantityFocusNodes.add(FocusNode());
      nameFocusNodes.add(FocusNode());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusOnEmptyRow();
    });
  }

  void _addRow() {
    setState(() {
      controller.addProduct(Product(quantity: '', name: ''));
      quantityFocusNodes.add(FocusNode());
      nameFocusNodes.add(FocusNode());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusOnEmptyRow();
    });
  }

  bool _isAllRowsFilled() {
    for (var product in controller.items) {
      if (product.name.isEmpty || product.quantity.isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool _shouldEnableButton() {
    bool isValid = false;
    for (var product in controller.items) {
      if (product.name.isNotEmpty || product.quantity.isNotEmpty) {
        if (!_isProductValid(product)) {
          return false;
        }
        isValid = true;
      }
    }
    return isValid;
  }

  bool _isProductValid(Product product) {
    if (product.name.isNotEmpty &&
        !RegExp(r'^[a-zA-Z\s]+$').hasMatch(product.name)) {
      return false;
    }
    if (product.quantity.isNotEmpty && int.tryParse(product.quantity) == null) {
      return false;
    }
    return true;
  }

  void _focusOnEmptyRow() {
    for (int i = 0; i < controller.items.length; i++) {
      if (controller.items[i].quantity.isEmpty ||
          controller.items[i].name.isEmpty) {
        FocusScope.of(context).requestFocus(quantityFocusNodes[i]);
        break;
      }
    }
  }

  void _handleFieldSubmitted(int index) {
    if (_isAllRowsFilled()) {
      _addRow();
    } else {
      _focusOnEmptyRow();
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      Get.to(OrderScreenTyped(orderNumber: _orderNumberController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagedrawer: Image.asset(
          "assets/icons/drawer.png",
          width: 23.25,
          height: 17,
        ),
      ),
      body: GetBuilder<ImageNoteController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  padding: const EdgeInsets.only(
                    right: 40,
                  ),
                  onPressed: _shouldEnableButton() ? _handleSubmit : null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: _shouldEnableButton()
                        ? AppColors.tealColor
                        : Colors.grey,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Order #',
                        style: TextStyle(
                          color: AppColors.purpleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _orderNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: AppColors.tealColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: controller.items.isEmpty
                      ? const Center(
                          child: Text('No products to display'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    left: 60,
                                    top: 14,
                                    bottom: 0,
                                    child: Container(
                                      width: 1,
                                      color: AppColors.tealColor,
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: controller.items.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final product = controller.items[index];
                                      return Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.tealColor,
                                                width: 0.9),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: TextFormField(
                                                  initialValue:
                                                      product.quantity,
                                                  focusNode:
                                                      quantityFocusNodes[index],
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    errorText: product.quantity
                                                                .isNotEmpty &&
                                                            !RegExp(r'^[0-9]+$')
                                                                .hasMatch(product
                                                                    .quantity)
                                                        ? 'Please enter a valid number'
                                                        : null,
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product.quantity = value;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isNotEmpty &&
                                                        int.tryParse(value) ==
                                                            null) {
                                                      return 'Please enter a valid number';
                                                    }
                                                    return null;
                                                  },
                                                  onFieldSubmitted: (_) {
                                                    _handleFieldSubmitted(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 9,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: SizedBox(
                                                  height: 60,
                                                  child: Autocomplete<String>(
                                                    optionsBuilder:
                                                        (TextEditingValue
                                                            textEditingValue) {
                                                      return productNames
                                                          .where((productName) {
                                                        return productName
                                                            .toLowerCase()
                                                            .contains(
                                                                textEditingValue
                                                                    .text
                                                                    .toLowerCase());
                                                      }).toList();
                                                    },
                                                    onSelected: (String
                                                        selectedProduct) {
                                                      setState(() {
                                                        product.name =
                                                            selectedProduct;
                                                      });
                                                      _handleFieldSubmitted(
                                                          index);
                                                    },
                                                    fieldViewBuilder: (
                                                      BuildContext context,
                                                      TextEditingController
                                                          textEditingController,
                                                      FocusNode focusNode,
                                                      VoidCallback
                                                          onFieldSubmitted,
                                                    ) {
                                                      textEditingController
                                                          .text = product.name;
                                                      return TextFormField(
                                                        controller:
                                                            textEditingController,
                                                        focusNode: focusNode,
                                                        onFieldSubmitted: (_) {
                                                          onFieldSubmitted();
                                                          _handleFieldSubmitted(
                                                              index);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          errorText: product
                                                                      .name
                                                                      .isNotEmpty &&
                                                                  !RegExp(r'^[a-zA-Z\s]+$')
                                                                      .hasMatch(
                                                                          product
                                                                              .name)
                                                              ? 'Only alphabets and spaces are allowed'
                                                              : null,
                                                        ),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            product.name =
                                                                value;
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value!
                                                                  .isNotEmpty &&
                                                              !RegExp(r'^[a-zA-Z\s]+$')
                                                                  .hasMatch(
                                                                      value)) {
                                                            return 'Only alphabets and spaces are allowed';
                                                          }
                                                          return null;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
