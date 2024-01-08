// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';

class SignPadScreen extends StatelessWidget {
  final DeliveryController deliveryController = Get.put(DeliveryController());
  final String deliverydocid;
  final DeliveryOrdersModel deliveryOrdersModel;
  SignPadScreen({
    Key? key,
    required this.deliverydocid,
    required this.deliveryOrdersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Sign"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: SfSignaturePad(
                key: signaturePadKey,
                minimumStrokeWidth: 1,
                maximumStrokeWidth: 3,
                strokeColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 222, 216, 161),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonContainerWidget(
                text: 'CONFORM',
                width: 200,
                height: 50,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                onTap: () async {
                  ui.Image image =
                      await signaturePadKey.currentState!.toImage();
                  final bytes =
                      await image.toByteData(format: ui.ImageByteFormat.png);
                  if (bytes != null) {
                    final buffer = bytes.buffer.asUint8List();
                    log(buffer.toString());

                    await uploadImagetoFirebase(buffer);
                  }
                })
          ],
        ),
      ),
    );
  }

  Future uploadImagetoFirebase(Uint8List imagepath) async {
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
              value, deliverydocid, deliveryOrdersModel);
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
