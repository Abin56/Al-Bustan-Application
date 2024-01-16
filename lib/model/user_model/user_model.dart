// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAuthModel {
  String docid;
  String email;
  String activate;
  String imageURl;
  String phoneNo;
  String name;
  UserAuthModel({
    required this.docid,
    required this.email,
    required this.activate,
    required this.imageURl,
    required this.phoneNo,
    required this.name,
  });

  UserAuthModel copyWith({
    String? docid,
    String? email,
    String? activate,
    String? imageURl,
    String? phoneNo,
    String? name,
  }) {
    return UserAuthModel(
      docid: docid ?? this.docid,
      email: email ?? this.email,
      activate: activate ?? this.activate,
      imageURl: imageURl ?? this.imageURl,
      phoneNo: phoneNo ?? this.phoneNo,
      name: name ?? this.name,
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
    };
  }

  factory UserAuthModel.fromMap(Map<String, dynamic> map) {
    return UserAuthModel(
      docid: map['docid'] ??'',
      email: map['email'] ??'',
      activate: map['activate'] ??'',
      imageURl: map['imageURl'] ??'',
      phoneNo: map['phoneNo'] ??'',
      name: map['name'] ??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuthModel.fromJson(String source) => UserAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserAuthModel(docid: $docid, email: $email, activate: $activate, imageURl: $imageURl, phoneNo: $phoneNo, name: $name)';
  }

  @override
  bool operator ==(covariant UserAuthModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.email == email &&
      other.activate == activate &&
      other.imageURl == imageURl &&
      other.phoneNo == phoneNo &&
      other.name == name;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      email.hashCode ^
      activate.hashCode ^
      imageURl.hashCode ^
      phoneNo.hashCode ^
      name.hashCode;
  }
}
