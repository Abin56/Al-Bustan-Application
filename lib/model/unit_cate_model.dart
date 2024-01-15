// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UnitCatModel {
  String docid;
  String value;
  UnitCatModel({
    required this.docid,
    required this.value,
  });

  UnitCatModel copyWith({
    String? docid,
    String? value,
  }) {
    return UnitCatModel(
      docid: docid ?? this.docid,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'value': value,
    };
  }

  factory UnitCatModel.fromMap(Map<String, dynamic> map) {
    return UnitCatModel(
      docid: map['docid'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitCatModel.fromJson(String source) =>
      UnitCatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UnitCatModel(docid: $docid, value: $value)';

  @override
  bool operator ==(covariant UnitCatModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid && other.value == value;
  }

  @override
  int get hashCode => docid.hashCode ^ value.hashCode;
}
