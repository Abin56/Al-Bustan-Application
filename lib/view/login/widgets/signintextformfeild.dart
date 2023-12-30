import 'package:flutter/material.dart';



class SigninTextFormfield extends StatelessWidget {
   SigninTextFormfield({
    super.key,
    this.textEditingController, 
     required this.labelText, 
     required this.hintText,
     this.function,
     this.suffixIcon,
     this.prefixIcon,
      this.icon, 
      this. obscureText,
     
  });
   TextEditingController? textEditingController;
   String labelText;
   String hintText;
   Widget? suffixIcon;
   Widget? prefixIcon;
   dynamic? obscureText;
   String? Function(String? fieldContent)? function;
        IconData? icon;
        

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 360,
      child: TextFormField(
    validator: function,
    obscureText :obscureText,
       controller: textEditingController,
       decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        ),
      ),
    );
  }
}