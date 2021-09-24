import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/provider/fav_provider.dart';
import 'package:flutter_default_code/screens/wishlist/wishlist_data.dart';
import 'package:flutter_default_code/services/global_methods.dart';
import 'package:provider/provider.dart';

import 'wishlist_empty.dart';

class Wishlist extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const Wishlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavProvider>(context);
    return favsProvider.getFavItems.isEmpty
        ? Scaffold(
      body: WishlistEmpty(),
    )
        : Scaffold(
        appBar: AppBar(
          title: Text('Wishlist (${favsProvider.getFavItems.length})'),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.showTheDialog(
                    'Clear wishlist!',
                    'Your wishlist will be cleared!',
                        () => favsProvider.clearFav(),
                    context);
                // cartProvider.clearCart();
              },
              icon: Icon(MyAppIcons.trash),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
              itemCount: favsProvider.getFavItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                    value: favsProvider.getFavItems.values.toList()[index],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: WishlistData(
                        productId: favsProvider.getFavItems.keys.toList()[index],
                      ),
                    ));
              }),
        ));
  }

}