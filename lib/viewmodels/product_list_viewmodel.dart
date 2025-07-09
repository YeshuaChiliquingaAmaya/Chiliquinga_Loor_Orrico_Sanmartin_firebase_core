// lib/viewmodels/product_list_viewmodel.dart
import 'package:flutter/material.dart';
import '../repositories/product_repository.dart';
import '../models/product.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  Stream<List<Product>>? _products;

  ProductListViewModel(this._productRepository) {
    _products = _productRepository.getProducts();
  }

  Stream<List<Product>>? get products => _products;
}