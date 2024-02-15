import 'dart:convert';

class DeliveryModel {
  String time;
  String docId;
  int orderCount;
  String orderid;
  bool assignStatus;
  bool isDelivered;
  bool pendingStatus;
  bool pickedUpStatus;
  String statusMessage;
  int price;
  String employeeName;
  String employeeId;
  String canteenName;
  String canteenId;

  DeliveryModel({
    required this.time,
    required this.docId,
    required this.orderCount,
    required this.orderid,
    required this.assignStatus,
    required this.isDelivered,
    required this.pendingStatus,
    required this.pickedUpStatus,
    required this.statusMessage,
    required this.price,
    required this.employeeName,
    required this.employeeId,
    required this.canteenName,
    required this.canteenId,
  });

  DeliveryModel copyWith({
    String? time,
    String? docId,
    int? orderCount,
    String? orderid,
    bool? assignStatus,
    bool? isDelivered,
    bool? pendingStatus,
    bool? pickedUpStatus,
    String? statusMessage,
    int? price,
    String? employeeName,
    String? employeeId,
    String? canteenName,
    String? canteenId,
  }) {
    return DeliveryModel(
      time: time ?? this.time,
      docId: docId ?? this.docId,
      orderCount: orderCount ?? this.orderCount,
      orderid: orderid ?? this.orderid,
      assignStatus: assignStatus ?? this.assignStatus,
      isDelivered: isDelivered ?? this.isDelivered,
      pendingStatus: pendingStatus ?? this.pendingStatus,
      pickedUpStatus: pickedUpStatus ?? this.pickedUpStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      price: price ?? this.price,
      employeeName: employeeName ?? this.employeeName,
      employeeId: employeeId ?? this.employeeId,
      canteenName: canteenName ?? this.canteenName,
      canteenId: canteenId ?? this.canteenId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'docId': docId,
      'orderCount': orderCount,
      'orderId': orderid,
      'assignStatus': assignStatus,
      'isDelivered': isDelivered,
      'pendingStatus': pendingStatus,
      'pickedUpStatus': pickedUpStatus,
      'statusMessage': statusMessage,
      'price': price,
      'employeeName': employeeName,
      'employeeId': employeeId,
      'canteenName': canteenName,
      'canteenId': canteenId,
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      time: map['time'] as String,
      docId: map['docId'] as String,
      orderCount: map['orderCount'] as int,
      orderid: map['orderId'] as String,
      assignStatus: map['assignStatus'] as bool,
      isDelivered: map['isDelivered'] as bool,
      pendingStatus: map['pendingStatus'] as bool,
      pickedUpStatus: map['pickedUpStatus'] as bool,
      statusMessage: map['statusMessage'] as String,
      price: map['price'] as int,
      employeeName: map['employeeName'] as String,
      employeeId: map['employeeId'] as String,
      canteenName: map['canteenName'] as String,
      canteenId: map['canteenId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryModel(time: $time, docId: $docId, orderCount: $orderCount, orderid: $orderid, assignStatus: $assignStatus, isDelivered: $isDelivered, pendingStatus: $pendingStatus, pickedUpStatus: $pickedUpStatus, statusMessage: $statusMessage, price: $price, employeeName: $employeeName, employeeId: $employeeId, canteenName: $canteenName, canteenId: $canteenId)';
  }

  @override
  bool operator ==(covariant DeliveryModel other) {
    if (identical(this, other)) return true;

    return other.time == time &&
        other.docId == docId &&
        other.orderCount == orderCount &&
        other.orderid == orderid &&
        other.assignStatus == assignStatus &&
        other.isDelivered == isDelivered &&
        other.pendingStatus == pendingStatus &&
        other.pickedUpStatus == pickedUpStatus &&
        other.statusMessage == statusMessage &&
        other.price == price &&
        other.employeeName == employeeName &&
        other.employeeId == employeeId &&
        other.canteenName == canteenName &&
        other.canteenId == canteenId;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        docId.hashCode ^
        orderCount.hashCode ^
        orderid.hashCode ^
        assignStatus.hashCode ^
        isDelivered.hashCode ^
        pendingStatus.hashCode ^
        pickedUpStatus.hashCode ^
        statusMessage.hashCode ^
        price.hashCode ^
        employeeName.hashCode ^
        employeeId.hashCode ^
        canteenName.hashCode ^
        canteenId.hashCode;
  }
}
