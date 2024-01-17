import 'package:canteen_productadd_application/controller/user_getDetails_controller.dart/user_auth_controller.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

editProfileFunctionOfNumber(BuildContext context){
  final UserAuthDetailController editProfileController = Get.find<UserAuthDetailController>();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  return
  customShowDilogBox(
    context:  context, 
  title: "Edit", 
  children: [
     Form(
      key: formkey,
       child: TextFormFiledContainerWidget(
        hintText: editProfileController.userPhoneNo.toString(), 
        title: "Mobile Number", 
        width: 210,
        controller:editProfileController. editPhoneNoController,
        validator: checkFieldEmpty,
        ),
     ),],
  doyouwantActionButton:true,
  actiononTapfuction: () {
    if(formkey.currentState!.validate()){
      editProfileController.editPhoneUserShowDetails();
    }
  
  },
  actiontext: "Update");
}

// editProfileFunctionOfEmail(BuildContext context){
//   return
//   customShowDilogBox(
//     context:  context, 
//   title: "Edit", 
//   children: [
//      TextFormFiledContainerWidget(hintText: "Do you want to edit", title: "Email Id", width: 210),],
//   doyouwantActionButton:true,
//   actiontext: "Update");
// }

editProfileFunctionOfName(BuildContext context){
    final UserAuthDetailController editProfileController = Get.find<UserAuthDetailController>();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    
  return
  customShowDilogBox(
    context:  context, 
  title: "Edit", 
  children: [
     Form(
      key: formkey,
       child: TextFormFiledContainerWidget(
        hintText: editProfileController.userName.toString(), 
        title: "Name", 
        width: 210,
        controller: editProfileController.editNameController,
        validator: checkFieldEmpty,),
     ),],
  doyouwantActionButton:true,
  actiononTapfuction: () {
    if(formkey.currentState!.validate()){}
  editProfileController. editNameUserShowDetails();
  },
  actiontext: "Update");
}