import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/model/unit_cate_model.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UnitCatDropDownWidget extends StatelessWidget {
  final AddProductController tempProductController =
      Get.put(AddProductController());
  UnitCatDropDownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: TextFormFiledContainerWidget(
                hintText: 'Enter Unit',
                title: 'Unit',
                width: double.infinity,
                validator: checkFieldEmpty,
                controller: tempProductController.unitController,
                keyboardType: TextInputType.number,
              ),
            )),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 05),
            child: SizedBox(
              height: 80,
              child: Center(
                  child: DropdownSearch<UnitCatModel>(
                autoValidateMode: AutovalidateMode.always,
                asyncItems: (value) {
                  tempProductController.unitCategoryModel.clear();

                  return tempProductController.fetchUnitCategorytypeModel();
                },
                itemAsString: (value) => value.value,
                onChanged: (value) async {
                  if (value != null) {
                    tempProductController.unitCategoryTypeName.value =
                        value.value;
                    tempProductController.unitCategoryTypeID.value =
                        value.docid;
                  }
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black.withOpacity(0.7))),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
