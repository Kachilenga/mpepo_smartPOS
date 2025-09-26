import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mpepo POS',
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.map((product) {
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ${product.price} Tax: ${product.tax}'),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading products'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}