// lib/viewmodels/add_product_viewmodel.dart
import 'package:flutter/material.dart';
import '../repositories/product_repository.dart';
import '../models/product.dart';

class AddProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  String _errorMessage = '';
  bool _isLoading = false;

  AddProductViewModel(this._productRepository);

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<bool> addProduct(
    String name, 
    String description, 
    double price, 
    String imageUrl, 
    String category, 
    String emprendimientoId
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    
    try {
      final newProduct = Product(
        id: '', // Se generará automáticamente en Firestore
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        category: category,
        emprendimientoId: emprendimientoId,
      );
      
      await _productRepository.addProduct(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al añadir el producto: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
