import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_app/common_widgets/custom_app_bar.dart';
import 'package:order_app/constants/colors.dart';

class OrderSettings extends StatelessWidget {
  final String orderNumber;
  final int totalQuantity; // Add this field

  const OrderSettings({
    super.key,
    required this.orderNumber,
    required this.totalQuantity, // Initialize this field
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: AppColors.tealColor,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                OrderSettingsText(
                  label: "Order#",
                  value: orderNumber,
                ),
                const SizedBox(height: 30),
                const OrderSettingsText(
                  label: "Order name",
                  value: "Joe’s catering",
                ),
                const SizedBox(height: 30),
                const OrderSettingsText(
                  label: "Delivery date",
                  value: "May 4th 3024",
                ),
                const SizedBox(height: 30),
                OrderSettingsText(
                  label: "Total quantity",
                  value: totalQuantity.toString(), // Use the passed quantity
                  valueColor: AppColors.blackColor,
                ),
                const SizedBox(height: 30),
                const OrderSettingsText(
                  label: "Estimated total",
                  value: "\$1402.96",
                  valueColor: AppColors.blackColor,
                ),
                const SizedBox(height: 30),
                const OrderSettingsText(
                  label: "Location",
                  value: "355 Onderdonk St\nMarina Dubai, UAE",
                  valueColor: AppColors.blackColor,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Delivery instructions...",
                  style: TextStyle(
                    color: AppColors.tealColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  height: 60,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.tealColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  "Save as draft",
                  style: TextStyle(
                    color: AppColors.tealColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSettingsText extends StatelessWidget {
  const OrderSettingsText({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = AppColors.tealColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 122,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.purpleColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 22),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
