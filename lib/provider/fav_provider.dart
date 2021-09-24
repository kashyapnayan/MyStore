import 'package:flutter/material.dart';
import 'package:flutter_default_code/models/fav_attributes.dart';

class FavProvider with ChangeNotifier {
  Map<String, FavAttributes> _favItems = {};

  Map<String, FavAttributes> get getFavItems => _favItems;

  void addAndRemoveFromFav(
      String productId, double price, String title, String imageUrl) {
    if (_favItems.containsKey(productId)) {
      removeItem(productId);
    }else{
      _favItems.putIfAbsent(
          productId,
              () => FavAttributes(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _favItems.remove(productId);
    notifyListeners();
  }

  void clearFav(){
    _favItems.clear();
    notifyListeners();
  }
}
