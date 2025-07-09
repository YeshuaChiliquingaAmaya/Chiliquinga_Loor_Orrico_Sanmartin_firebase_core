// lib/repositories/product_repository.dart
import '../services/firestore_service.dart';
import '../models/product.dart';

class ProductRepository {
  final FirestoreService _firestoreService;

  ProductRepository(this._firestoreService);

  Stream<List<Product>> getProducts() {
    return _firestoreService.getProducts();
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _firestoreService.getProductsByCategory(category);
  }

  Future<void> addProduct(Product product) async {
    await _firestoreService.addProduct(product);
  }
}
