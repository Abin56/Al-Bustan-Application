import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../widgets/textform feild Widget/textformfeildWidget.dart';

class AddProduct extends StatefulWidget {
  final String barcodeValue;

  const AddProduct({super.key, required this.barcodeValue});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddProductController addProductController =
      Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
     
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GooglePoppinsWidgets(
                    text: 'ADD PRODUCT',
                    fontsize: 15,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: SizedBox(
                    height: 60,
                    width: 240,
                    child: SfBarcodeGenerator(
                      symbology: Code128(),
                      value: widget.barcodeValue,
                      showValue: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter product name',
                  title: 'Product name',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: addProductController.productnameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter price',
                  title: 'Price',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: addProductController.productpriceController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter quantity',
                  title: 'Quantity',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: addProductController.quantityController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter expiry Date',
                  title: 'Expiry Date',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: addProductController.expirydateController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: ButtonContainerWidget(
                  text: 'Submit',
                  width: 370,
                  height: 50,
                  fontSize: 18,
                  onTap: () async {
                    // final _formKey=key;
                    if (_formKey.currentState!.validate()) {
                      await addProductController.addProduct(
                          widget.barcodeValue, context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
