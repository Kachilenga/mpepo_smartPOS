import '../models/cart_item.dart';

class CartService {
  static final List<CartItem> _items = [];

  static void addToCart(CartItem item) {
    final existing = _items.firstWhere(
          (i) => i.product.id == item.product.id,
      orElse: () => CartItem(product: item.product, quantity: 0),
    );

    if (existing.quantity == 0) {
      _items.add(item);
    } else {
      existing.quantity += item.quantity;
    }
  }

  static List<CartItem> get items => _items;

  static double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.total);

  static double get totalTax =>
      _items.fold(0, (sum, item) => sum + item.tax);

  static double get grandTotal => subtotal + totalTax;

  static void clearCart() => _items.clear();
}