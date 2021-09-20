import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  static const routeName = '/CartScreen';
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cart'),
      ),
    );
  }
}
