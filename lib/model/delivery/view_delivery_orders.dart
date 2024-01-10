// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliveryOrdersModel {
  String orderId;
  int orderCount;
  String status;
  String time;
  String signURl;
  String deliveredtime;
  DeliveryOrdersModel({
    required this.orderId,
    required this.orderCount,
    required this.status,
    required this.time,
    required this.signURl,
    required this.deliveredtime,
  });

  DeliveryOrdersModel copyWith({
    String? orderId,
    int? orderCount,
    String? status,
    String? time,
    String? signURl,
    String? deliveredtime,
  }) {
    return DeliveryOrdersModel(
      orderId: orderId ?? this.orderId,
      orderCount: orderCount ?? this.orderCount,
      status: status ?? this.status,
      time: time ?? this.time,
      signURl: signURl ?? this.signURl,
      deliveredtime: deliveredtime ?? this.deliveredtime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderCount': orderCount,
      'status': status,
      'time': time,
      'signURl': signURl,
      'deliveredtime': deliveredtime,
    };
  }

  factory DeliveryOrdersModel.fromMap(Map<String, dynamic> map) {
    return DeliveryOrdersModel(
      orderId: map['orderId'] ?? '',
      orderCount: map['orderCount'] ?? 0,
      status: map['status'] ?? '',
      time: map['time'] ?? '',
      signURl: map['signURl'] ?? '',
      deliveredtime: map['deliveredtime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryOrdersModel.fromJson(String source) =>
      DeliveryOrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryOrdersModel(orderId: $orderId, orderCount: $orderCount, status: $status, time: $time, signURl: $signURl, deliveredtime: $deliveredtime)';
  }

  @override
  bool operator ==(covariant DeliveryOrdersModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.orderCount == orderCount &&
        other.status == status &&
        other.time == time &&
        other.signURl == signURl &&
        other.deliveredtime == deliveredtime;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        orderCount.hashCode ^
        status.hashCode ^
        time.hashCode ^
        signURl.hashCode ^
        deliveredtime.hashCode;
  }
}
