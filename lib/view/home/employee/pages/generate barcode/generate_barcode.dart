
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class GenerateBarcode extends StatelessWidget {
  const GenerateBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: SizedBox(height: 100,width: 400,child: SfBarcodeGenerator(
            symbology: Code128(),
            value: '234234234234',
          ),),),
    );
  }
}
// void buildBarcode(
//   Barcode bc,
//   String data, {
//   String? filename,
//   double? width,
//   double? height,
//   double? fontHeight,
// }) {
//   /// Create the Barcode
//   final svg = bc.toSvg(
//     data,
//     width: width ?? 200,
//     height: height ?? 80,
//     fontHeight: fontHeight,
//   );

//   // Save the image
//   filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
//   File('$filename.svg').writeAsStringSync(svg);
// }