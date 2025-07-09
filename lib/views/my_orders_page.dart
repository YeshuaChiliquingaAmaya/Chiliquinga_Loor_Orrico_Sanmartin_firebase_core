// lib/views/my_orders_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/my_orders_viewmodel.dart';
import '../models/order.dart'; // Importar el modelo Order

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myOrdersViewModel = Provider.of<MyOrdersViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
      ),
      body: StreamBuilder<List<Order>>(
        stream: myOrdersViewModel.userOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tienes pedidos realizados.'));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 2,
                child: ExpansionTile(
                  title: Text('Pedido #${order.id.substring(0, 6)} - ${order.orderDate.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text('Estado: ${order.status} | Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                  children: order.items.map((item) => ListTile(
                    title: Text('${item.productName} x${item.quantity}'),
                    trailing: Text('\$${(item.priceAtOrder * item.quantity).toStringAsFixed(2)}'),
                  )).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
