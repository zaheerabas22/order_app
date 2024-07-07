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
    
    items.addAll([
      
    ]);
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

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
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
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    product.imagePath = image.path;
                    update(); 
                  }
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  product.note = notesController.text;
                  update(); 
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void addProduct(Product product) {
    items.add(product);
    update(); 
  }
}
