// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:canteen_productadd_application/controller/calender_controller/calender_controller.dart';
import 'package:canteen_productadd_application/controller/wareHouse_controller/warehouse_controller.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/widgets/calender/calender.dart';
import 'package:canteen_productadd_application/view/widgets/isLoadin_showDilogue/isaLoading_diloguebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:uuid/uuid.dart';

class AddProductWareHouseAdmin extends StatelessWidget {
  final deliveryController = Get.put(CalenderController());
  final WareHouseController wareHouseController =
      Get.put(WareHouseController());
  final ProductAddingModel resultData;
  final String barcoodevalue;
  AddProductWareHouseAdmin({
    Key? key,
    required this.barcoodevalue,
    required this.resultData,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: SizedBox(
                    height: 60,
                    width: 300,
                    child: SfBarcodeGenerator(
                      symbology: Code128(),
                      value: barcoodevalue,
                      showValue: true,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GooglePoppinsWidgets(
                              text: "PRODUCT NAME", fontsize: 12),
                          GooglePoppinsWidgets(
                            text: resultData.productname,
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GooglePoppinsWidgets(
                              text: "COMPANY NAME", fontsize: 12),
                          GooglePoppinsWidgets(
                            text: resultData.companyName,
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GooglePoppinsWidgets(text: "MAIN CATEGORY", fontsize: 12),
                      GooglePoppinsWidgets(
                        text: resultData.categoryName,
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GooglePoppinsWidgets(text: "SUB CATEGORY", fontsize: 12),
                      GooglePoppinsWidgets(
                        text: resultData.subcategoryName,
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GooglePoppinsWidgets(text: "UNIT", fontsize: 12),
                      GooglePoppinsWidgets(
                        text: resultData.unitcategoryName,
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter Out Price',
                  title: 'Out Price',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: wareHouseController.outpriceController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter In price',
                  title: 'In Price',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: wareHouseController.inpriceController,
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
                  controller: wareHouseController.quantityController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextFormFiledContainerWidget(
                  hintText: 'Enter Alert limit eg 1,50,100..',
                  title: 'Stock limit',
                  width: 380,
                  validator: checkFieldEmpty,
                  controller: wareHouseController.productlimitController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child:
                    GooglePoppinsWidgets(text: 'Expiry Date', fontsize: 12.5),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            SizedBox(
                                height: 300,
                                width: 300,
                                child: CalendarWidget())
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 380,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: GooglePoppinsWidgets(
                              text: deliveryController.date.value == null
                                  ? "Choose Expiry Date"
                                  : dateConveter(deliveryController.date.value),
                              fontsize: 12.5,
                              color: cBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // child: TextFormFiledContainerWidget(
                //   hintText: 'Enter in days eg 1,50,100..',
                //   title: 'Expiry Date',
                //   width: 380,
                //   validator: checkFieldEmpty,
                //   controller: wareHouseController.expirydateController,
                //   keyboardType: TextInputType.number,
                // ),
              ),
              Obx(
                () => wareHouseController.productuploading.value == true
                    ? const LoadingLottieWidget(height: 50, width: 200)
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: ButtonContainerWidget(
                          text: 'Submit',
                          width: 370,
                          height: 50,
                          fontSize: 18,
                          onTap: () async {
                            wareHouseController.productuploading.value = true;
                            final uuid = const Uuid().v1();
                            String a = resultData.productname;

                            // list.join()
                            String s = a.substring(0, 4);
                            String i = a.substring(0, 3);
                            log(s);
                            getRandomInt(4);

                            if (_formKey.currentState!.validate()) {
                              await wareHouseController.addProduct2(
                                  '${resultData.productname}$uuid', //docid, //docid
                                  int.parse(barcoodevalue), //barcode
                                  "$i${getRandomInt(4)}", //ite,code,
                                  resultData,
                                  context);
                            }
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
