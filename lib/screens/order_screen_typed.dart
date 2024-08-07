import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_app_bar.dart';
import 'package:order_app/constants/colors.dart';
import 'package:order_app/controller/image_note_controller.dart';
import 'package:order_app/models/product_model.dart';
import 'package:order_app/screens/ordr_settings.dart';

class OrderScreenTyped extends StatelessWidget {
  final ImageNoteController controller = Get.put(ImageNoteController());
  final String orderNumber;

  OrderScreenTyped({super.key, required this.orderNumber});

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
          List<Product> filteredProducts = controller.items
              .where((product) =>
                  product.quantity.isNotEmpty || product.name.isNotEmpty)
              .toList();

          filteredProducts.addAll(
              List.generate(10, (index) => Product(quantity: '', name: '')));

          int totalQuantity = filteredProducts.fold(
            0,
            (sum, product) => sum + (int.tryParse(product.quantity) ?? 0),
          );

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0, left: 49),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        "assets/icons/cancel.png",
                        height: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(OrderSettings(
                          orderNumber: orderNumber,
                          totalQuantity: totalQuantity,
                        ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.tealColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 30,
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Row(
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
                          child: Text(
                            orderNumber,
                            style: const TextStyle(
                              color: AppColors.tealColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: filteredProducts.isEmpty
                      ? const Center(
                          child: Text('No products to display'),
                        )
                      : Stack(
                          children: [
                            Positioned(
                              left: 53,
                              top: 7,
                              bottom: 0,
                              child: Container(
                                width: 1,
                                color: AppColors.tealColor,
                              ),
                            ),
                            ListView.builder(
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final Product product = filteredProducts[index];
                                return GestureDetector(
                                  onDoubleTap: () => controller.showEditModal(
                                      context, product),
                                  onLongPress: () => controller.showEditModal(
                                      context, product),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 49,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        margin: const EdgeInsets.only(left: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.tealColor,
                                                width: 1),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              product.quantity,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 49,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.tealColor,
                                                  width: 1),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              if (product.note.isNotEmpty)
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.teal),
                                                ),
                                              if (product.imagePath.isNotEmpty)
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Icon(Icons.camera_alt,
                                                      color: Colors.teal),
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
                          ],
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
