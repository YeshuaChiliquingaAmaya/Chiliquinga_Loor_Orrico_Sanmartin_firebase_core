// lib/views/category_products_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/category_products_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../models/product.dart'; // Importar el modelo Product

class CategoryProductsPage extends StatelessWidget {
  final String category;
  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryProductsViewModel = Provider.of<CategoryProductsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos de $category'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: categoryProductsViewModel.categoryProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos en la categoría "$category".'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 2,
                child: ListTile(
                  leading: Image.network(
                    product.imageUrl.isNotEmpty ? product.imageUrl : 'https://placehold.co/100x100/CCCCCC/000000?text=No+Image',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://placehold.co/100x100/CCCCCC/000000?text=No+Image',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      Provider.of<CartViewModel>(context, listen: false).addItemToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} añadido al carrito')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}