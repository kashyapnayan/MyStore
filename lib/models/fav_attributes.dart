import 'package:flutter/material.dart';

class FavAttributes with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavAttributes(
      {required this.id,
        required this.title,
        required this.price,
        required this.imageUrl});
}
