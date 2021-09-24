import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/provider/cart_provider.dart';
import 'package:flutter_default_code/services/global_methods.dart';
import 'package:provider/provider.dart';

import 'cart_data.dart';
import 'cart_empty.dart';

class Cart extends StatelessWidget {
  static const routeName = '/CartScreen';
  const Cart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  icon: Icon(MyAppIcons.trash),
                  onPressed: () {
                    GlobalMethods.showTheDialog(
                        'Clear cart!',
                        'Your cart will be cleared!',
                            () =>
                                cartProvider.clearCart(),
                        context);
                  },
                ),
              ],
            ),
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList()[index],
                        child: CartData(
                          productId: cartProvider.getCartItems.keys.toList()[index],
                        ));
                  }),
            ));
  }

  Widget checkoutSection(BuildContext ctx, double total) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {},
                      splashColor: Theme.of(ctx).splashColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total: ',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US \$${total.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
