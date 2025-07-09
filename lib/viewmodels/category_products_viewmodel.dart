// lib/viewmodels/category_products_viewmodel.dart
import 'package:flutter/material.dart';
import '../repositories/product_repository.dart';
import '../models/product.dart';

class CategoryProductsViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  Stream<List<Product>>? _categoryProducts;

  CategoryProductsViewModel(this._productRepository, String category) {
    _categoryProducts = _productRepository.getProductsByCategory(category);
  }

  Stream<List<Product>>? get categoryProducts => _categoryProducts;
}