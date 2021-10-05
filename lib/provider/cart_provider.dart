import 'package:flutter/material.dart';
import 'package:flutter_default_code/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttributes> _cartItems = {};

  Map<String, CartAttributes> get getCartItems => _cartItems;

  double get totalAmount {
    double _total = 0.0;
    _cartItems.forEach((key, value) {
      _total += value.price * value.quantity;
    });
    return _total;
  }

  void addProductToCart(
      String productId, double price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartAttributes(
              id: existingCartItem.id,
              productId: existingCartItem.productId,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              imageUrl: existingCartItem.imageUrl));
    }else{
      _cartItems.putIfAbsent(
          productId,
              () => CartAttributes(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void reduceItemByOne(String productId){
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
              (existingCartItem) => CartAttributes(
              id: existingCartItem.id,
              productId: existingCartItem.productId,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              imageUrl: existingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
