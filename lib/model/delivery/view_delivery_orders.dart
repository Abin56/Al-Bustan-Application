// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliveryOrdersModel {
  String orderId;
  int orderCount;
  String status;
  String time;
  String signURl;
  DeliveryOrdersModel({
    required this.orderId,
    required this.orderCount,
    required this.status,
    required this.time,
    required this.signURl,
  });

  DeliveryOrdersModel copyWith({
    String? orderId,
    int? orderCount,
    String? status,
    String? time,
    String? signURl,
  }) {
    return DeliveryOrdersModel(
      orderId: orderId ?? this.orderId,
      orderCount: orderCount ?? this.orderCount,
      status: status ?? this.status,
      time: time ?? this.time,
      signURl: signURl ?? this.signURl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderCount': orderCount,
      'status': status,
      'time': time,
      'signURl': signURl,
    };
  }

  factory DeliveryOrdersModel.fromMap(Map<String, dynamic> map) {
    return DeliveryOrdersModel(
      orderId: map['orderId'] ?? '',
      orderCount: map['orderCount'] ?? 0,
      status: map['status'] ?? '',
      time: map['time'] ?? '',
      signURl: map['signURl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryOrdersModel.fromJson(String source) =>
      DeliveryOrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryOrdersModel(orderId: $orderId, orderCount: $orderCount, status: $status, time: $time, signURl: $signURl)';
  }

  @override
  bool operator ==(covariant DeliveryOrdersModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.orderCount == orderCount &&
        other.status == status &&
        other.time == time &&
        other.signURl == signURl;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        orderCount.hashCode ^
        status.hashCode ^
        time.hashCode ^
        signURl.hashCode;
  }
}
