import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/model/sub_category_model.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryDropDownWidget extends StatelessWidget {
  final AddProductController tempProductController =
      Get.put(AddProductController());
  SubCategoryDropDownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: GoogleMonstserratWidgets(
              text: 'Sub Category',
              fontsize: 11,
              fontWeight: FontWeight.bold,
            )),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 80,
            child: Center(
                child: DropdownSearch<SubCategoryModel>(
              autoValidateMode: AutovalidateMode.always,
              asyncItems: (value) {
                tempProductController.unitCategoryModel.clear();

                return tempProductController.fetchSubCategorytypeModel();
              },
              itemAsString: (value) => value.subcategoryName,
              onChanged: (value) async {
                if (value != null) {
                  tempProductController.subCategoryTypeName.value =
                      value.subcategoryName;
                  tempProductController.subCategoryTypeID.value = value.docid;
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
