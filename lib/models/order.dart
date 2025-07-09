// lib/models/order.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final DateTime orderDate;
  final String status;
  final double totalAmount;
  final List<OrderItem> items;

  Order({this.id = '', required this.userId, required this.orderDate, required this.status, required this.totalAmount, required this.items});

  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    List<OrderItem> orderItems = (data['items'] as List<dynamic>?)
        ?.map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
        .toList() ?? [];
    return Order(
      id: doc.id,
      userId: data['userId'] ?? '',
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      status: data['status'] ?? '',
      totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
      items: orderItems,
    );
  }

  Map<String, dynamic> toMap(String currentUserId) {
    return {
      'userId': currentUserId,
      'orderDate': Timestamp.fromDate(orderDate),
      'status': status,
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double priceAtOrder;

  OrderItem({required this.productId, required this.productName, required this.quantity, required this.priceAtOrder});

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      priceAtOrder: (map['priceAtOrder'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'priceAtOrder': priceAtOrder,
    };
  }
}
