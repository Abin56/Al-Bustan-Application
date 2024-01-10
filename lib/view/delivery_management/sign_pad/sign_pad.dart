// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/widgets/isLoadin_showDilogue/isaLoading_diloguebox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';

class SignPadScreen extends StatelessWidget {
  final String docid;
  final DeliveryController deliveryController = Get.put(DeliveryController());
  final GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  final String deliverydocid;
  final DeliveryOrdersModel deliveryOrdersModel;
  SignPadScreen({
    Key? key,
    required this.deliverydocid,
    required this.deliveryOrdersModel,
    required this.docid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Sign"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: SfSignaturePad(
                key: signaturePadKey,
                minimumStrokeWidth: 1,
                maximumStrokeWidth: 3,
                strokeColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 222, 216, 161),
              ),
            ),
            const SizedBox(
              height: 05,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 400,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('EmployeeProfile')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('DeliveryHistory')
                        .doc(docid)
                        .collection('ProductItems')
                        .snapshots(),
                    builder: (context, snaps) {
                      if (snaps.hasData) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              final data = AllProductDetailModel.fromMap(
                                  snaps.data!.docs[index].data());
                              return Container(
                                color: themeColorBlue.withOpacity(0.4),
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      GoogleMonstserratWidgets(
                                        text: "${index + 1}",
                                        fontsize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: GoogleMonstserratWidgets(
                                          text: data.productname,
                                          fontsize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      GoogleMonstserratWidgets(
                                        text: "QTY",
                                        fontsize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: GoogleMonstserratWidgets(
                                          text: data.quantityinStock.toString(),
                                          fontsize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 05,
                              );
                            },
                            itemCount: snaps.data!.docs.length);
                      } else {
                        return const Center(
                          child: circularPIndicator,
                        );
                      }
                    }),
              ),
            ),
            Obx(() => deliveryController.signIsLoading.value == true
                ? const LoadingLottieWidget(height: 100, width: 200)
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: ButtonContainerWidget(
                          text: 'CONFORM',
                          width: 200,
                          height: 50,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          onTap: () async {
                            deliveryController.signIsLoading.value = true;
                            ui.Image image =
                                await signaturePadKey.currentState!.toImage();
                            final bytes = await image.toByteData(
                                format: ui.ImageByteFormat.png);
                            if (bytes != null) {
                              final buffer = bytes.buffer.asUint8List();
                              log(buffer.toString());

                              await uploadImagetoFirebase(buffer, context);
                            }
                          }),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImagetoFirebase(
      Uint8List imagepath, BuildContext context) async {
    log('image data $imagepath');
    final datetime = DateTime.now();
    try {
      final firebaseStorageBucket = FirebaseStorage.instance;

      final storeRef = firebaseStorageBucket
          .ref()
          .child('DeliveySignCollection/$datetime.png');

      await storeRef.putData(imagepath).whenComplete(() async {
        await storeRef.getDownloadURL().then((value) async {
          log("url >>>>>>>>>>>>>>>$value");
          await deliveryController.deliverdsign(
              value, deliverydocid, deliveryOrdersModel, context);
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
