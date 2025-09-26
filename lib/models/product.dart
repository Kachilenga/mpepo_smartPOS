class Product {
  final int id;
  final String name;
  final double price;
  final double tax;

  Product({required this.id, required this.name, required this.price, required this.tax});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      tax: json['tax'],
    );
  }
}