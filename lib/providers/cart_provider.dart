import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      state = List.from(state)
        ..[index] = state[index].copyWith(quantity: state[index].quantity + 1);
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void incrementQuantity(Product product) {
    state =
        state.map((item) {
          if (item.product.id == product.id) {
            return item.copyWith(quantity: item.quantity + 1);
          }
          return item;
        }).toList();
  }

  void decrementQuantity(Product product) {
    state =
        state
            .map((item) {
              if (item.product.id == product.id) {
                return item.quantity > 1
                    ? item.copyWith(quantity: item.quantity - 1)
                    : null;
              }
              return item;
            })
            .whereType<CartItem>()
            .toList();
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  double get totalPrice {
    return state.fold(
      0.0,
      (total, item) => total + (item.product.discountedPrice * item.quantity),
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
