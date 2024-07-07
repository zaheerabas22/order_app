import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_app_bar.dart';
import 'package:order_app/constants/colors.dart';
import 'package:order_app/controller/image_note_controller.dart';
import 'package:order_app/models/product_model.dart';
import 'package:order_app/screens/ordr_settings.dart';

class OrderScreenTyped extends StatelessWidget {
  final ImageNoteController controller = Get.put(ImageNoteController());

  OrderScreenTyped({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        imagedrawer: Image.asset("assets/icons/drawer.png"),
      ),
      body: GetBuilder<ImageNoteController>(
        builder: (controller) {
          List<Product> allProducts = [
            ...controller.items,
            ...List.generate(10, (index) => Product(quantity: '', name: ''))
          ];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                        Get.to(const OrderSettings());
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.tealColorLite,
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
                  child: allProducts.isEmpty
                      ? const Center(
                          child: Text('No products to display'),
                        )
                      : Stack(
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
                              itemCount: allProducts.length,
                              itemBuilder: (context, index) {
                                final Product product = allProducts[index];
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
                                                color: Colors.teal, width: 0.5),
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
                                                  color: Colors.teal,
                                                  width: 0.5),
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
                                              if (product.note!.isNotEmpty)
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.teal),
                                                ),
                                              if (product.imagePath!.isNotEmpty)
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
