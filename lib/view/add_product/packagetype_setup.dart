import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/model/packagetype_model.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageSetUpWidget extends StatelessWidget {
  final AddProductController tempProductController =
      Get.put(AddProductController());
  PackageSetUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: GoogleMonstserratWidgets(
              text: 'Package type',
              fontsize: 11,
              fontWeight: FontWeight.bold,
            )),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 80,
            child: Center(
                child: DropdownSearch<PackageTypeModel>(
              autoValidateMode: AutovalidateMode.always,
              asyncItems: (value) {
                tempProductController.packageTypeModel.clear();

                return tempProductController.fetchPackagetypeModel();
              },
              itemAsString: (value) => value.typevalue,
              onChanged: (value) async {
                if (value != null) {
                  tempProductController.packageTypeName.value = value.typevalue;
                  tempProductController.packageTypeID.value = value.docid;
                }
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: GoogleFonts.poppins(
                      fontSize: 13, color: Colors.black.withOpacity(0.7))),
            )),
          ),
        ),
      ],
    );
  }
}
