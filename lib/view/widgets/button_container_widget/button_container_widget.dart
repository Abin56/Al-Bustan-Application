// ignore_for_file: must_be_immutable

import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../fonts/google_poppins.dart';

class ButtonContainerWidget extends StatelessWidget {
  void Function() onTap;
  final String text;
  final double width;
    final double height;
    final double fontSize;
   final FontWeight? fontWeight;




   ButtonContainerWidget({super.key,required this.text ,this.fontWeight, required this.width,required this.height,required this. fontSize,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: themeColorBlue,
          borderRadius: BorderRadius.horizontal(),
        ),
        width: width,
        height: height,
        child: Center(
          child: GooglePoppinsWidgets(
            textAlign: TextAlign.center,
            color: cWhite,
            fontWeight: fontWeight,
            text: text,
            fontsize: fontSize, 
          ),
        ),
      ),
    );
  }
}


class ColorButtonContainerWidget extends StatelessWidget {
  final String text;
  final Color color;

  const ColorButtonContainerWidget({super.key, required this.text,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.horizontal(),
      ),
      width: 180,
      height: 40,
      child: Center(
        child: GooglePoppinsWidgets(
          textAlign: TextAlign.center,
          color: cWhite,
          fontWeight: FontWeight.bold,
          text: text,
          fontsize: 14,
        ),
      ),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Function onPressed;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF35B2A2),
            Color(0xFF11967F),
            Color(0xFF06876A),
            Color(0xFF036952),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

