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
      TextEditingController(text: '112096');

  @override
  void initState() {
    super.initState();
    _addInitialRows();
  }

  void _addInitialRows() {
    for (int i = 0; i < 10; i++) {
      controller.addProduct(Product(quantity: '', name: ''));
    }
  }

  void _addRow() {
    setState(() {
      controller.addProduct(Product(quantity: '', name: ''));
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagedrawer: Image.asset("assets/icons/drawer.png"),
      ),
      body: GetBuilder<ImageNoteController>(
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: _shouldEnableButton()
                            ? () {
                                Get.to(OrderScreenTyped(
                                    orderNumber: _orderNumberController.text));
                              }
                            : null,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: _shouldEnableButton()
                              ? AppColors.tealColorLite
                              : Colors.grey,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      const Text(
                        'Order #',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
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
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
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
                                      top: 7,
                                      bottom: 0,
                                      child: Container(
                                        width: 1,
                                        color: Colors.teal,
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
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.teal,
                                                  width: 0.5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  child: TextFormField(
                                                    initialValue:
                                                        product.quantity,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      errorText: _isProductValid(
                                                              product)
                                                          ? null
                                                          : 'Please enter a valid number',
                                                    ),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        product.quantity =
                                                            value;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter quantity';
                                                      }
                                                      if (int.tryParse(value) ==
                                                          null) {
                                                        return 'Please enter a valid number';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 9,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
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
                                                    },
                                                    fieldViewBuilder: (BuildContext
                                                            context,
                                                        TextEditingController
                                                            textEditingController,
                                                        FocusNode focusNode,
                                                        VoidCallback
                                                            onFieldSubmitted) {
                                                      textEditingController
                                                          .text = product.name;
                                                      return TextFormField(
                                                        controller:
                                                            textEditingController,
                                                        focusNode: focusNode,
                                                        onFieldSubmitted: (_) =>
                                                            onFieldSubmitted(),
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
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shouldEnableButton() ? _addRow : null,
        backgroundColor:
            _shouldEnableButton() ? AppColors.tealColorLite : Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
