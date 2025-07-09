// lib/repositories/order_repository.dart
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../models/product.dart';
import '../models/order.dart' as order_model;

class OrderRepository {
  final FirestoreService _firestoreService;
  final AuthService _authService;

  OrderRepository(this._firestoreService, this._authService);

  Future<void> placeOrder(List<Product> cartItems) async {
    final user = await _authService.user.first;
    if (user == null) {
      throw Exception('Usuario no autenticado para realizar un pedido.');
    }

    final totalAmount = cartItems.fold(0.0, (sum, item) => sum + item.price);
    final orderItems = cartItems.map((p) => order_model.OrderItem(
      productId: p.id,
      productName: p.name,
      quantity: 1,
      priceAtOrder: p.price,
    )).toList();

    final newOrder = order_model.Order(
      userId: user.uid,
      orderDate: DateTime.now(),
      status: 'pendiente',
      totalAmount: totalAmount,
      items: orderItems,
    );

    await _firestoreService.addOrder(newOrder);
  }

  Stream<List<order_model.Order>> getUserOrders(String userId) {
    return _firestoreService.getUserOrders(userId);
  }
}
