import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:flutter/material.dart';

editProfileFunctionOfNumber(BuildContext context){
  return
  customShowDilogBox(
    context:  context, 
  title: "Edit", 
  children: [
     TextFormFiledContainerWidget(hintText: "Do you want to edit", title: "Mobile Number", width: 210),],
  doyouwantActionButton:true);
}

editProfileFunctionOfEmail(BuildContext context){
  return
  customShowDilogBox(
    context:  context, 
  title: "Edit", 
  children: [
     TextFormFiledContainerWidget(hintText: "Do you want to edit", title: "Email Id", width: 210),],
  doyouwantActionButton:true);
}

editProfileFunctionOfName(BuildContext context){
  return
  customShowDilogBox(
    context:  context, 
  title: "Edit", 
  children: [
     TextFormFiledContainerWidget(hintText: "Do you want to edit", title: "Name", width: 210),],
  doyouwantActionButton:true);
}