// lib/viewmodels/my_orders_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/order_repository.dart';
import '../repositories/user_repository.dart';
import '../models/order.dart';

class MyOrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  Stream<List<Order>>? _userOrders;

  MyOrdersViewModel(this._orderRepository, this._userRepository) {
    _userRepository.currentUser.listen((user) {
      if (user != null) {
        _userOrders = _orderRepository.getUserOrders(user.uid);
        notifyListeners();
      } else {
        _userOrders = Stream.value([]);
        notifyListeners();
      }
    });
  }

  Stream<List<Order>>? get userOrders => _userOrders;
}
