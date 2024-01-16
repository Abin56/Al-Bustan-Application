import 'package:flutter/material.dart';



class SigninTextFormfield extends StatelessWidget {
  const SigninTextFormfield({
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
 final  TextEditingController? textEditingController;
  final String labelText;
   final String hintText;
  final Widget? suffixIcon;
   final Widget? prefixIcon;
    final dynamic obscureText;
  final String? Function(String? fieldContent)? function;
       final IconData? icon;
        

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