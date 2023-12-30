// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductAddingModel {
  String docId;
  String barcodeNumber;
  String productname;
  int price;
  int quantityinStock;
  String expiryDate;
  String addDate;

  ProductAddingModel({
    required this.docId,
    required this.barcodeNumber,
    required this.productname,
    required this.price,
    required this.quantityinStock,
    required this.expiryDate,
    required this.addDate,
  });

  ProductAddingModel copyWith({
    String? docId,
    String? barcodeNumber,
    String? productname,
    int? price,
    int? quantityinStock,
    String? expiryDate,
    String? addDate,
  }) {
    return ProductAddingModel(
      docId: docId ?? this.docId,
      barcodeNumber: barcodeNumber ?? this.barcodeNumber,
      productname: productname ?? this.productname,
      price: price ?? this.price,
      quantityinStock: quantityinStock ?? this.quantityinStock,
      expiryDate: expiryDate ?? this.expiryDate,
      addDate: addDate ?? this.addDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'barcodeNumber': barcodeNumber,
      'productname': productname,
      'price': price,
      'quantityinStock': quantityinStock,
      'expiryDate': expiryDate,
      'addDate': addDate,
    };
  }

  factory ProductAddingModel.fromMap(Map<String, dynamic> map) {
    return ProductAddingModel(
      docId: map['docId'] ?? '',
      barcodeNumber: map['barcodeNumber'] ?? '',
      productname: map['productname'] ?? '',
      price: map['price'] ?? 0,
      quantityinStock: map['quantityinStock'] ?? 0,
      expiryDate: map['expiryDate'] ?? '',
      addDate: map['addDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductAddingModel.fromJson(String source) => ProductAddingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductAddingModel(docId: $docId, barcodeNumber: $barcodeNumber, productname: $productname, price: $price, quantityinStock: $quantityinStock, expiryDate: $expiryDate, addDate: $addDate)';
  }

  @override
  bool operator ==(covariant ProductAddingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docId == docId &&
      other.barcodeNumber == barcodeNumber &&
      other.productname == productname &&
      other.price == price &&
      other.quantityinStock == quantityinStock &&
      other.expiryDate == expiryDate &&
      other.addDate == addDate;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
      barcodeNumber.hashCode ^
      productname.hashCode ^
      price.hashCode ^
      quantityinStock.hashCode ^
      expiryDate.hashCode ^
      addDate.hashCode;
  }
}
