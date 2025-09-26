import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  CartScreen({required this.cartItems});

  double calculateTotal() {
    double subtotal = cartItems.fold(0, (sum, item) => sum + item.price);
    double tax = cartItems.fold(0, (sum, item) => sum + item.tax);
    double discount = subtotal * 0.1;
    return subtotal + tax - discount;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();
    return Scaffold(
      appBar: AppBar(title: Text('Receipt')),
      body: Column(
        children: [
          ...cartItems.map((item) => ListTile(
            title: Text(item.name),
            subtitle: Text('Price: ${item.price} Tax: ${item.tax}'),
          )),
          Divider(),
          Text('Total: $total'),
        ],
      ),
    );
  }
}