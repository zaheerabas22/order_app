import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/auto_complete.dart';
import 'package:order_app/common_widgets/custom_appbar';
import 'package:order_app/common_widgets/image_picket.dart';
import 'package:order_app/controller/order_controller.dart';
import 'package:order_app/models/product_model.dart';
import 'package:order_app/screens/preview_screen.dart';


class OrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  OrderScreen({super.key});

  void _showNoteImageModal(BuildContext context, int index) {
    final product = orderController.products[index];
    final noteController = TextEditingController(text: product.notes);

    showDialog(
      context: context,
      builder: (context) {
        return NoteImageModal(
          noteController: noteController,
          onSave: (note, imagePath) {
            final updatedProduct = Product(
              name: product.name,
              quantity: product.quantity,
              notes: note,
              imagePath: imagePath,
            );
            orderController.updateProduct(index, updatedProduct);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Screen'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ProductAutocomplete(controller: _productNameController),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final productName = _productNameController.text;
                            final quantity = int.parse(_quantityController.text);

                            orderController.addProduct(Product(
                              name: productName,
                              quantity: quantity,
                            ));

                            _productNameController.clear();
                            _quantityController.clear();
                          }
                        },
                        child: Text('Add Row'),
                      ),
                      SizedBox(width: 20),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: orderController.isButtonEnabled.value
                              ? () {
                                  Get.to(() => PreviewScreen());
                                }
                              : null,
                          child: Text('Submit'),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: orderController.products.length,
                  itemBuilder: (context, index) {
                    final product = orderController.products[index];
                    return GestureDetector(
                      onDoubleTap: () => _showNoteImageModal(context, index),
                      onLongPress: () => _showNoteImageModal(context, index),
                      child: ListTile(
                        title: Text('${product.name} x ${product.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (product.notes != null && product.notes!.isNotEmpty)
                              Icon(Icons.info, color: Colors.blue),
                            if (product.imagePath != null && product.imagePath!.isNotEmpty)
                              Icon(Icons.image, color: Colors.green),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                orderController.removeProduct(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
