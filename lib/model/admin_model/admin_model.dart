// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminModel {
  String docid;
  String email;
  bool activate;
  String imageURl;
  String phoneNo;
  String name;
  String password;
  String userrole;
  bool assignpower;
  AdminModel({
    required this.docid,
    required this.email,
    required this.activate,
    required this.imageURl,
    required this.phoneNo,
    required this.name,
    required this.password,
    required this.userrole,
    required this.assignpower,
  });

  AdminModel copyWith({
    String? docid,
    String? email,
    bool? activate,
    String? imageURl,
    String? phoneNo,
    String? name,
    String? password,
    String? userrole,
    bool? assignpower,
  }) {
    return AdminModel(
      docid: docid ?? this.docid,
      email: email ?? this.email,
      activate: activate ?? this.activate,
      imageURl: imageURl ?? this.imageURl,
      phoneNo: phoneNo ?? this.phoneNo,
      name: name ?? this.name,
      password: password ?? this.password,
      userrole: userrole ?? this.userrole,
      assignpower: assignpower ?? this.assignpower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'email': email,
      'activate': activate,
      'imageURl': imageURl,
      'phoneNo': phoneNo,
      'name': name,
      'password': password,
      'userrole': userrole,
      'assignpower': assignpower,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      docid: map['docid'] ??'',
      email: map['email'] ??'',
      activate: map['activate'] ?? false,
      imageURl: map['imageURl'] ??'',
      phoneNo: map['phoneNo'] ??'',
      name: map['name'] ??'',
      password: map['password'] ??'',
      userrole: map['userrole'] ??'',
      assignpower: map['assignpower'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminModel(docid: $docid, email: $email, activate: $activate, imageURl: $imageURl, phoneNo: $phoneNo, name: $name, password: $password, userrole: $userrole, assignpower: $assignpower)';
  }

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.email == email &&
      other.activate == activate &&
      other.imageURl == imageURl &&
      other.phoneNo == phoneNo &&
      other.name == name &&
      other.password == password &&
      other.userrole == userrole &&
      other.assignpower == assignpower;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      email.hashCode ^
      activate.hashCode ^
      imageURl.hashCode ^
      phoneNo.hashCode ^
      name.hashCode ^
      password.hashCode ^
      userrole.hashCode ^
      assignpower.hashCode;
  }
}