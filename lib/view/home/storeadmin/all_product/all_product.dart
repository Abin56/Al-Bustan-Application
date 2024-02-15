import 'package:canteen_productadd_application/controller/all_product_controller/all_product_controller.dart';
import 'package:canteen_productadd_application/controller/store_controller/store_controller.dart';
import 'package:canteen_productadd_application/controller/wareHouse_controller/warehouse_controller.dart';
import 'package:canteen_productadd_application/model/category_model/subcategory_model.dart';
import 'package:canteen_productadd_application/model/category_model/unit_type_model.dart';
import 'package:canteen_productadd_application/model/company_model/company_model.dart';
import 'package:canteen_productadd_application/model/packagetype_model.dart';
import 'package:canteen_productadd_application/model/product_category_model/product_category_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/storeadmin/all_product/search_all_product/seach_screen.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:canteen_productadd_application/view/widgets/icon%20back%20button/icon_back_button.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllStockList extends StatelessWidget {
  AllStockList({super.key});

  final getStroreCtr = Get.put(StoreController());
  final allProductCtr = Get.put(AllProductController());
  final wearhouseCtr = Get.put(WareHouseController());

  final TextEditingController categoryCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    allProductCtr.searchControllerString.value = "";
    wearhouseCtr.productCompanyName.value = "";
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: sizeH,
        width: sizeW,
        decoration: BoxDecoration(
            color: cWhite,
            // borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(blurRadius: 0.5),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 1650,
                      child: Row(
                        children: [
                          // const ImageWidget(
                          //     image:
                          //         'web_images/drawer_images/inventory.png'),
                          sw10,
                          GooglePoppinsWidgets(
                            text: 'All Stocks',
                            fontsize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          // const Spacer(),
                          sw50,
                          IconButton(
                            onPressed: () {
                              Get.to(SearchScreen());
                            },
                            icon: iconWidget(
                                icon: Icons.search, color: cBlack, size: 25),
                          ),
                          SizedBox(
                            height: 40,
                            width: 200,
                            child: Obx(
                              () => CupertinoSearchTextField(
                                  backgroundColor: cLateGrey,
                                  placeholderStyle:
                                      const TextStyle(color: cGrey),
                                  placeholder: allProductCtr.filterName.value,
                                  // controller: allProductCtr.searchController,
                                  onChanged: (value) {
                                    if (allProductCtr.filterName.value ==
                                        "Product Name") {
                                      // allProductCtr.searchByProductName(value);
                                      allProductCtr
                                          .searchByProductWithCompanyName(
                                              allProductCtr
                                                  .searchControllerString.value,
                                              wearhouseCtr
                                                  .productCompanyName.value);
                                    } else {
                                      allProductCtr.searchByCompanyName(value);
                                    }

                                    allProductCtr.searchControllerString.value =
                                        value;
                                  }),
                            ),
                          ),
                          sw5,
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cLateGrey),
                            child: PopupMenuButton(
                              position: PopupMenuPosition.under,
                              icon: iconWidget(
                                  icon: Icons.filter_alt_sharp,
                                  color: cGrey,
                                  size: 25),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    onTap: () {
                                      allProductCtr.filterName.value =
                                          "Product Name";
                                    },
                                    child: GooglePoppinsWidgets(
                                        text: "Product Name", fontsize: 14)),
                                PopupMenuItem(
                                    onTap: () {
                                      allProductCtr.filterName.value =
                                          "Company Name";
                                    },
                                    child: GooglePoppinsWidgets(
                                        text: "Company Name", fontsize: 14))
                              ],
                            ),
                          ),
                          sw5,
                          Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: cBlack.withOpacity(0.2))),
                            child: Center(
                              child: DropdownSearch<SuppliersModel>(
                                validator: (item) {
                                  if (item == null) {
                                    return "Required field";
                                  } else {
                                    return null;
                                  }
                                },
                                asyncItems: (value) {
                                  wearhouseCtr.supplierList.clear();
                                  return wearhouseCtr.fetchSupplireModel();
                                },
                                itemAsString: (value) => value.suppliersName,
                                onChanged: (value) async {
                                  if (value != null) {
                                    wearhouseCtr.productCompanyName.value =
                                        value.suppliersName;
                                    wearhouseCtr.productCompanyID.value =
                                        value.docId;
                                  }
                                  allProductCtr.searchByProductWithCompanyName(
                                      allProductCtr
                                          .searchControllerString.value,
                                      wearhouseCtr.productCompanyName.value);
                                },
                                onSaved: (value) {
                                  // Do something with the selected value when the form is saved.
                                  // You can update the data or perform any necessary actions.
                                  // print("Form saved: $value");
                                },
                                clearButtonProps: ClearButtonProps(
                                  // isVisible: true,
                                  icon: const Icon(Icons.close),
                                  iconSize: 15,
                                  onPressed: () {
                                    wearhouseCtr.productCompanyName.value = "";
                                    allProductCtr
                                        .searchByProductWithCompanyName(
                                            allProductCtr
                                                .searchControllerString.value,
                                            wearhouseCtr
                                                .productCompanyName.value);
                                  },
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  textAlign: TextAlign.center,
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          hintText: 'Select Company'),
                                  baseStyle: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: 'Search Company')),
                                    searchDelay: Duration(microseconds: 10)),
                              ),
                            ),
                          ),

                          sw10,
                          MaterialButton(
                            onPressed: () {
                              // Get.to(ProductAddingScreen());
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: cGreen),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: GooglePoppinsWidgets(
                                      text: "Add Stock",
                                      fontsize: 14,
                                      color: cWhite),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    width: 1650,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Item Code'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Item Name'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Company'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Category'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: "Subcategory"),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Unit'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'PackageType'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Limit'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'Expiry Date'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: 'InPrice'),
                            ListViewTableHeaderWidget(
                                width: 150, headerTitle: "Action"),
                          ],
                        ),
                        Expanded(
                            child: Obx(
                          () => allProductCtr.searchControllerString.value == ""
                              ? Container(
                                  decoration: const BoxDecoration(),
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection(
                                              'AllProductStockCollection')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot
                                            .data!.docs.isEmpty) {
                                          return Center(
                                            child: GooglePoppinsWidgets(
                                                text: "No data", fontsize: 15),
                                          );
                                        } else if (!snapshot.hasData) {
                                          return Center(
                                            child: GooglePoppinsWidgets(
                                                text: "No data", fontsize: 15),
                                          );
                                        } else {
                                          return ListView.separated(
                                              // scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final productData =
                                                    ProductAddingModel.fromMap(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data());
                                                return InventoryTileWidget(
                                                  productData: productData,
                                                  index: index,
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider();
                                              },
                                              itemCount:
                                                  snapshot.data!.docs.length);
                                        }
                                      }),
                                )
                              : Container(
                                  color: cLateGrey,
                                  child: ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // final product = searchResults[index];
                                      final product =
                                          allProductCtr.searchList.value[index];
                                      return InventoryTileWidget(
                                        productData: product,
                                        index: index,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider();
                                    },
                                    itemCount: allProductCtr.searchList.length,
                                  ),
                                ),
                        ))
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InventoryTileWidget extends StatelessWidget {
  InventoryTileWidget({
    required this.productData,
    required this.index,
    super.key,
  });

  final getWarehouseCtr = Get.put(WareHouseController());
  final allProductCtr = Get.put(AllProductController());

  final int index;

  final ProductAddingModel productData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.barcodeNumber,
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.productname,
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.companyName,
          ),

          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.categoryName.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.subcategoryName.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.unitcategoryName.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.packageType.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.limit.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.expiryDate.toString(),
          ),
          DataContainerWidget(
            index: index,
            width: 150,
            headerTitle: productData.inPrice.toString(),
          ),

          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    customShowDilogBox(
                        context: context,
                        title: "Shopkeeper Datails",
                        children: [
                          // const StoreKeeperDatailsWidget(),
                        ],
                        doyouwantActionButton: true);
                    // ShowDialogWidget(context, StoreKeeperDatailsWidget());
                  },
                  child: GooglePoppinsWidgets(
                      text: 'Storekeeper details', fontsize: 11),
                ),
                //  <<< Edit  >>>>
                PopupMenuItem(
                  onTap: () {
                    allProductCtr.productNameController.text =
                        productData.productname;
                    allProductCtr.limitCtr.text = productData.limit.toString();
                    allProductCtr.expiryDateController.text =
                        productData.expiryDate;
                    allProductCtr.inPriceController.text =
                        productData.inPrice.toString();
                    customShowDilogBox(
                      context: context,
                      title: "Edit",
                      children: [
                        TextFormFiledContainerWidget(
                          controller: allProductCtr.productNameController,
                          hintText: "Item Name",
                          title: 'Item Name',
                          width: 500,
                        ),
                        TextFormFiledContainerWidget(
                            controller: allProductCtr.limitCtr,
                            hintText: "Limit",
                            title: 'Limit',
                            width: 500),
                        TextFormFiledContainerWidget(
                            controller: allProductCtr.expiryDateController,
                            hintText: "Expiry Date",
                            title: 'Expiry Date',
                            width: 500),
                        TextFormFiledContainerWidget(
                          controller: allProductCtr.inPriceController,
                          hintText: "InPrice",
                          title: 'InPrice',
                          width: 500,
                        ),
                        sh10,
                        GooglePoppinsWidgets(
                            text: "Company Name", fontsize: 14),
                        // drop
                        CompanySetUpWidget1(),
                        sh10,
                        GooglePoppinsWidgets(text: "Category", fontsize: 14),
                        CategorySetUpWidget1(),
                        sh10,
                        GooglePoppinsWidgets(text: "Subcategory", fontsize: 14),
                        SubCategorySetUpWidget1(),
                        sh10,
                        GooglePoppinsWidgets(text: "Unit", fontsize: 14),
                        UnitSetUpWidget1(),
                        sh10,
                        GooglePoppinsWidgets(
                            text: "Package Type", fontsize: 14),
                        PackageSetUpWidget1(),
                      ],
                      doyouwantActionButton: true,
                      actiononTapfuction: () {
                        allProductCtr.editProductList(
                          productData.docId,
                          allProductCtr.productNameController.text,
                          allProductCtr.expiryDateController.text,
                          int.parse(allProductCtr.inPriceController.text),
                          int.parse(allProductCtr.limitCtr.text),
                          getWarehouseCtr.productCompanyName.value,
                          getWarehouseCtr.productCompanyID.value,
                          getWarehouseCtr.productCategoryName.value,
                          getWarehouseCtr.productCategoryID.value,
                          getWarehouseCtr.productSubCategoryID.value,
                          getWarehouseCtr.productSubCategoryName.value,
                          getWarehouseCtr.productUnitID.value,
                          getWarehouseCtr.productUnitName.value,
                          getWarehouseCtr.productPackageID.value,
                          getWarehouseCtr.productPackageName.value,
                        );
                      },
                    );
                  },
                  child: GooglePoppinsWidgets(
                    text: 'Edit',
                    fontsize: 11,
                  ),
                )
              ];
            },
          )
        ],
      ),
    );
  }
}

class ListViewTableHeaderWidget extends StatelessWidget {
  final String headerTitle;
  final double? width;

  const ListViewTableHeaderWidget({
    this.width,
    required this.headerTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
          color: cLateGrey,
          border: Border.symmetric(
            horizontal: BorderSide(color: cBlack.withOpacity(0.5)),
          )),
      child: Center(
        child: Text(
          headerTitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}

class DataContainerWidget extends StatelessWidget {
  final int index;
  final String headerTitle;
  final double? width;
  final Color? color;
  final double? height;

  const DataContainerWidget({
    required this.index,
    this.color,
    this.width,
    this.height,
    required this.headerTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: Text(
          headerTitle,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.5),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.image,
    super.key,
  });

  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30, width: 30, child: Image.asset(image));
  }
}

class CategorySetUpWidget1 extends StatelessWidget {
  CategorySetUpWidget1({
    Key? key,
  }) : super(key: key);

  final wearhouseCtr = Get.put(WareHouseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
          child: DropdownSearch<ProductCategoryModel>(
        validator: (item) {
          if (item == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // autoValidateMode: AutovalidateMode.always,
        asyncItems: (value) {
          wearhouseCtr.productCategoryList.clear();

          return wearhouseCtr.fetchProductCategoryModel();
        },
        itemAsString: (value) => value.categoryName,
        onChanged: (value) async {
          if (value != null) {
            wearhouseCtr.productCategoryName.value = value.categoryName;
            wearhouseCtr.productCategoryID.value = value.docid;
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.poppins(
                fontSize: 13, color: Colors.black.withOpacity(0.7))),
      )),
    );
  }
}

class SubCategorySetUpWidget1 extends StatelessWidget {
  SubCategorySetUpWidget1({
    Key? key,
  }) : super(key: key);

  final wearhouseCtr = Get.put(WareHouseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
          child: DropdownSearch<ProductSubcategoryModel>(
        validator: (item) {
          if (item == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // autoValidateMode: AutovalidateMode.always,
        asyncItems: (value) {
          wearhouseCtr.productSubCategoryList.clear();

          return wearhouseCtr.fetchProductSubCategoryModel();
        },
        itemAsString: (value) => value.subcategoryName,
        onChanged: (value) async {
          if (value != null) {
            wearhouseCtr.productSubCategoryName.value = value.subcategoryName;
            wearhouseCtr.productSubCategoryID.value = value.docid;
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.poppins(
                fontSize: 13, color: Colors.black.withOpacity(0.7))),
      )),
    );
  }
}

class UnitSetUpWidget1 extends StatelessWidget {
  UnitSetUpWidget1({
    Key? key,
  }) : super(key: key);

  final wearhouseCtr = Get.put(WareHouseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
          child: DropdownSearch<UnitCategoryModel>(
        validator: (item) {
          if (item == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // autoValidateMode: AutovalidateMode.always,
        asyncItems: (value) {
          wearhouseCtr.unitCategoryList.clear();

          return wearhouseCtr.fetchUnitCategoryModel();
        },
        itemAsString: (value) => value.unitCategoryName,
        onChanged: (value) async {
          if (value != null) {
            wearhouseCtr.productUnitName.value = value.unitCategoryName;
            wearhouseCtr.productUnitID.value = value.docid;
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      )),
    );
  }
}

class PackageSetUpWidget1 extends StatelessWidget {
  PackageSetUpWidget1({
    Key? key,
  }) : super(key: key);

  final wearhouseCtr = Get.put(WareHouseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
          child: DropdownSearch<PackageTypeModel>(
        validator: (item) {
          if (item == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // autoValidateMode: AutovalidateMode.always,
        asyncItems: (value) {
          wearhouseCtr.packageTypeList.clear();

          return wearhouseCtr.fetchPackageTypeModel();
        },
        itemAsString: (value) => value.typevalue,
        onChanged: (value) async {
          if (value != null) {
            wearhouseCtr.productPackageName.value = value.typevalue;
            wearhouseCtr.productPackageID.value = value.docid;
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.poppins(
                fontSize: 13, color: Colors.black.withOpacity(0.7))),
      )),
    );
  }
}

class CompanySetUpWidget1 extends StatelessWidget {
  CompanySetUpWidget1({
    Key? key,
  }) : super(key: key);

  final wearhouseCtr = Get.put(WareHouseController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
        child: Form(
          key: _formKey,
          child: DropdownSearch<SuppliersModel>(
            validator: (item) {
              if (item == null) {
                return "Required field";
              } else {
                return null;
              }
            },
            asyncItems: (value) {
              wearhouseCtr.supplierList.clear();
              return wearhouseCtr.fetchSupplireModel();
            },
            itemAsString: (value) => value.suppliersName,
            onChanged: (value) async {
              if (value != null) {
                wearhouseCtr.productCompanyName.value = value.suppliersName;
                wearhouseCtr.productCompanyID.value = value.docId;
              }
            },
            onSaved: (value) {
              // Do something with the selected value when the form is saved.
              // You can update the data or perform any necessary actions.
              print("Form saved: $value");
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            popupProps: const PopupProps.menu(
                showSearchBox: true, searchDelay: Duration(microseconds: 10)),
          ),
        ),
      ),
    );
  }
}
