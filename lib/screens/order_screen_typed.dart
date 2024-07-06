import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_app/screens/ordr_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class Product {
  String name;
  String quantity;
  String? notes;
  String? imagePath;

  Product({
    required this.name,
    required this.quantity,
    this.notes,
    this.imagePath,
  });
}

class OrderScreenTyped extends StatefulWidget {
  const OrderScreenTyped({super.key});

  @override
  _OrderScreenTypedState createState() => _OrderScreenTypedState();
}

class _OrderScreenTypedState extends State<OrderScreenTyped> {
  final List<Product> items = [
    Product(name: 'papas', quantity: '10'),
    Product(name: 'papa dulce', quantity: '3'),
    Product(name: 'coca cola', quantity: '3'),
    Product(name: 'ginger ale', quantity: '4'),
    Product(name: 'Sprite', quantity: '1'),
    Product(name: 'queso cheddar (long press)', quantity: '5'),
    Product(name: 'contenedores para llevar S', quantity: '2'),
    Product(name: 'contenedores L', quantity: '1'),
    Product(name: 'aceite para freidora', quantity: '2'),
    Product(name: 'bounty', quantity: '1'),
  ];

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
  }

  void _showEditModal(Product product) async {
    await _requestPermissions();

    final TextEditingController notesController =
        TextEditingController(text: product.notes);
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
                    setState(() {
                      product.imagePath = image.path;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  setState(() {
                    product.notes = notesController.text;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
          color: AppColors.tealColorLite,
        ),
        title: Image.asset(
          "assets/images/logo.png",
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/cancel.png",
                  height: 22,
                ),
                IconButton(
                    onPressed: () {
                      Get.to(const OrderSettings());
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.tealColorLite,
                      size: 35,
                    ))
              ],
            ),
          ),
          const SizedBox(height: 30),
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
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Positioned(
                    left: 70,
                    top: 7,
                    bottom: 0,
                    child: Container(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  ListView.builder(
                    itemCount: items.length + 14,
                    itemBuilder: (context, index) {
                      if (index < items.length) {
                        final item = items[index];
                        return GestureDetector(
                          onLongPress: () {
                            _showEditModal(item);
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 49,
                                width: MediaQuery.of(context).size.width * 0.14,
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
                                      item.quantity,
                                      style: const TextStyle(fontSize: 16),
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
                                          color: Colors.teal, width: 0.5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      if (item.notes != null)
                                        const Icon(Icons.info,
                                            color: Colors.teal),
                                      if (item.imagePath != null)
                                        const Icon(Icons.camera_alt,
                                            color: Colors.teal),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 49,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.teal, width: 0.5),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
