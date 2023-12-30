import 'dart:io';

import 'package:canteen_productadd_application/view/controller/create_profileController/create_profile_controller.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CircleAvatharImageSelectionWidget extends StatefulWidget {
  const CircleAvatharImageSelectionWidget({
    super.key,
  });

  @override
  State<CircleAvatharImageSelectionWidget> createState() =>
      _CircleAvatharImageSelectionWidgetState();
}

class _CircleAvatharImageSelectionWidgetState
    extends State<CircleAvatharImageSelectionWidget> {
  CreateProfileController createProfileController =
      Get.put(CreateProfileController());

  bool isImageSelected = false;
  File? imageFile;

  pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        isImageSelected = true;
        createProfileController.employeeImagePath.value = imageFile;
        if (kDebugMode) {
          print(
              "Image path  ${createProfileController.employeeImagePath.value}");
        }
      } else {
        if (kDebugMode) {
          print('User didnt pick any image.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  pickImagefromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        isImageSelected = true;
        createProfileController.employeeImagePath.value = imageFile;
        if (kDebugMode) {
          print(
              "Image path  ${createProfileController.employeeImagePath.value}");
        }
      } else {
        if (kDebugMode) {
          print('User didnt pick any image.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (createProfileController.employeeImagePath.value == null) {
            return CircleAvatar(
              //bg img removed

              radius: 70,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color.fromARGB(255, 52, 50, 50),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          color: Colors.white,
                          onPressed: () async {
                            getbottomSheetForPickIMage(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                CircleAvatar(
                  //bg img removed
                  backgroundImage: FileImage(
                      createProfileController.employeeImagePath.value!),

                  radius: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonContainerWidget(
                      text: 'CHANGE',
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        createProfileController.employeeImagePath.value = null;
                      }),
                )
              ],
            );
          }
        }),
      ],
    );
  }

  Future<void> getbottomSheetForPickIMage(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          pickImagefromGallery();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.photo_size_select_actual_outlined,
                          size: 45,
                        )),
                    const SizedBox(
                      width: 2,
                    ),
                    IconButton(
                        onPressed: () {
                          pickImagefromCamera();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          size: 45,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
