import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_app/models/product_model.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageNoteController extends GetxController {
  RxList<Product> items = RxList<Product>();

  @override
  void onInit() {
    super.onInit();
    items.addAll([]);
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  Future<void> showEditModal(BuildContext context, Product product) async {
    await requestPermissions();

    final TextEditingController notesController =
        TextEditingController(text: product.note);
    final ImagePicker picker = ImagePicker();

    if (!Get.isOverlaysOpen) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding:
                MediaQuery.of(context).viewInsets + const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Select Image'),
                  onPressed: () async {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select Image Source'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Take Photo'),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.camera);
                                    if (image != null) {
                                      product.imagePath = image.path;
                                      update();
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Choose from Gallery'),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      product.imagePath = image.path;
                                      update();
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        product.note = notesController.text;
                        update();
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void addProduct(Product product) {
    items.add(product);
    update();
  }
}
