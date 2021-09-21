import 'package:flutter/material.dart';
import 'package:flutter_default_code/screens/wishlist/wishlist_data.dart';

import 'wishlist_empty.dart';

class Wishlist extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const Wishlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<int> wishlist = [1];
    return wishlist.isEmpty
        ? Scaffold(
      body: WishlistEmpty(),
    )
        : Scaffold(
        body: Container(
          margin: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctx, int index) {
                return WishlistData(productId: '12',);
              }),
        ));
  }

}