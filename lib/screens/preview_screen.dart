import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_appbar';
import 'package:order_app/controller/order_controller.dart';

class PreviewScreen extends StatelessWidget {
  final OrderController orderController = Get.find<OrderController>();

  PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Preview Order'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Order Number: 12345', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: orderController.products.length,
                  itemBuilder: (context, index) {
                    final product = orderController.products[index];
                    return ListTile(
                      title: Text('${product.name} x ${product.quantity}'),
                      subtitle: product.notes != null ? Text(product.notes!) : null,
                      trailing: product.imagePath != null
                          ? Image.file(File(product.imagePath!), width: 50, height: 50)
                          : null,
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
