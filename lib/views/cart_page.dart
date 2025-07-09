// lib/views/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../models/product.dart'; // Importar el modelo Product

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    void showOrderConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Confirmar Pedido'),
            content: Text('¿Estás seguro de que quieres realizar el pedido por \$${cartViewModel.totalAmount.toStringAsFixed(2)}?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  bool success = await cartViewModel.placeOrder();
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pedido realizado con éxito!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al realizar el pedido o carrito vacío.')),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Expanded(
          child: cartViewModel.cartItems.isEmpty
              ? const Center(child: Text('Tu carrito está vacío.'))
              : ListView.builder(
                  itemCount: cartViewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartViewModel.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 2,
                      child: ListTile(
                        leading: Image.network(
                          item.imageUrl.isNotEmpty ? item.imageUrl : 'https://placehold.co/100x100/CCCCCC/000000?text=No+Image',
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
                        title: Text(item.name),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            cartViewModel.removeItemFromCart(item);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Total: \$${cartViewModel.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: showOrderConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Realizar Pedido', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
