import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView(
        children: items.map((item) {
          return ListTile(
            title: Text('${item.product.name} x${item.quantity}'),
            subtitle: Text('Total: ${item.total} Tax: ${item.tax}'),
          );
        }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Grand Total: ${CartService.grandTotal}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}