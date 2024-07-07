import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_app_bar.dart';
import 'package:order_app/constants/colors.dart';
import 'package:order_app/controller/image_note_controller.dart';
import 'package:order_app/models/product_list.dart';
import 'package:order_app/models/product_model.dart';
import 'package:order_app/screens/order_screen_typed.dart';

class OrderScreenNoTyped extends StatefulWidget {
  const OrderScreenNoTyped({Key? key}) : super(key: key);

  @override
  _OrderScreenNoTypedState createState() => _OrderScreenNoTypedState();
}

class _OrderScreenNoTypedState extends State<OrderScreenNoTyped> {
  final ImageNoteController controller = Get.put(ImageNoteController());
  bool isButtonEnabled = false;

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
    controller.addProduct(Product(quantity: '', name: ''));
  }

  bool _shouldEnableButton() {
    for (int i = 0; i < controller.items.length; i++) {
      if (controller.items[i].quantity.isNotEmpty ||
          controller.items[i].name.isNotEmpty) {
        return true;
      }
    }
    return false;
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(OrderScreenTyped());
                      },
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
              Container(
                height: 30,
                margin: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Order # ',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '112096',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
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
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 20),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.teal, width: 0.5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(fontSize: 16),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        controller.items[index].quantity =
                                            value;
                                        setState(() {
                                          isButtonEnabled =
                                              _shouldEnableButton();
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter quantity';
                                        }
                                        if (int.tryParse(value) == null) {
                                          return 'Please enter valid number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Autocomplete<String>(
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        return productNames
                                            .where((productName) {
                                          return productName
                                              .toLowerCase()
                                              .contains(textEditingValue.text
                                                  .toLowerCase());
                                        }).toList();
                                      },
                                      onSelected: (String selectedProduct) {
                                        controller.items[index].name =
                                            selectedProduct;
                                        setState(() {
                                          isButtonEnabled =
                                              _shouldEnableButton();
                                        });
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController
                                              textEditingController,
                                          FocusNode focusNode,
                                          VoidCallback onFieldSubmitted) {
                                        textEditingController.text =
                                            controller.items[index].name;
                                        return TextFormField(
                                          controller: textEditingController,
                                          focusNode: focusNode,
                                          onFieldSubmitted: (_) =>
                                              onFieldSubmitted(),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(fontSize: 16),
                                          onChanged: (value) {
                                            controller.items[index].name =
                                                value;
                                            setState(() {
                                              isButtonEnabled =
                                                  _shouldEnableButton();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter product name';
                                            }
                                            if (!RegExp(r'^[a-zA-Z]+$')
                                                .hasMatch(value)) {
                                              return 'Only alphabets are allowed';
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
                ),
              ),
            ],
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
