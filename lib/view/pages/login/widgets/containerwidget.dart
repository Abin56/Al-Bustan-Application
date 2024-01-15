import 'dart:io';

import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
 final double height;
final  double width;
 final String imagePath;

 const ContainerImage({
    required this.height,
    required this.width,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(imagePath),fit: BoxFit.fill)),
    );
  }
}

class NetworkContainerImage extends StatelessWidget {
 final double height;
final  double width;
final  String imagePath;

 const NetworkContainerImage({
    required this.height,
    required this.width,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(File(imagePath)))),
    );
  }
}