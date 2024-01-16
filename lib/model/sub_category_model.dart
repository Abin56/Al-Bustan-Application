// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubCategoryModel {
  String docid;
  String subcategoryName;
  SubCategoryModel({
    required this.docid,
    required this.subcategoryName,
  });

  SubCategoryModel copyWith({
    String? docid,
    String? subcategoryName,
  }) {
    return SubCategoryModel(
      docid: docid ?? this.docid,
      subcategoryName: subcategoryName ?? this.subcategoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'subcategoryName': subcategoryName,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      docid: map['docid'] ?? '',
      subcategoryName: map['subcategoryName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubCategoryModel(docid: $docid, subcategoryName: $subcategoryName)';

  @override
  bool operator ==(covariant SubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid && other.subcategoryName == subcategoryName;
  }

  @override
  int get hashCode => docid.hashCode ^ subcategoryName.hashCode;
}
