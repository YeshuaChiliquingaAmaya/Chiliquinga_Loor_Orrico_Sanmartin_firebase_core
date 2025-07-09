// lib/viewmodels/cart_viewmodel.dart
import 'package:flutter/material.dart';
import '../repositories/order_repository.dart';
import '../models/product.dart';

class CartViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  List<Product> _cartItems = [];

  CartViewModel(this._orderRepository);

  List<Product> get cartItems => _cartItems;

  double get totalAmount => _cartItems.fold(0.0, (sum, item) => sum + item.price);

  void addItemToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeItemFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  Future<bool> placeOrder() async {
    if (_cartItems.isEmpty) {
      return false;
    }
    try {
      await _orderRepository.placeOrder(_cartItems);
      _cartItems = [];
      notifyListeners();
      return true;
    } catch (e) {
      print('Error al realizar el pedido: ${e.toString()}');
      return false;
    }
  }
}