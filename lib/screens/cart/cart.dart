import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:flutter_default_code/consts/firebase_const.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/provider/cart_provider.dart';
import 'package:flutter_default_code/services/global_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'cart_data.dart';
import 'cart_empty.dart';

class Cart extends StatefulWidget {
  static const routeName = '/CartScreen';
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isLoading = false;

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
                        () => cartProvider.clearCart(),
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
                          productId:
                              cartProvider.getCartItems.keys.toList()[index],
                        ));
                  }),
            ));
  }

  Widget checkoutSection(BuildContext ctx, double total) {
    final cartProvider = Provider.of<CartProvider>(ctx);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Placing your Order...',
                      style: TextStyle(
                          color: Theme.of(ctx).textSelectionColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              : Row(
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
                            onTap: () async {
                              //ToDo: Add Payment Integration

                              setState(() {
                                _isLoading = true;
                              });
                              User? user = _auth.currentUser;
                              final _uid = user!.uid;
                              cartProvider.getCartItems
                                  .forEach((key, orderValue) async {
                                final orderId = uuid.v4();
                                try {
                                  await FirebaseFirestore.instance
                                      .collection(FirebaseCollectionConst
                                          .ordersCollection)
                                      .doc(orderId)
                                      .set({
                                    'orderId': orderId,
                                    'userId': _uid,
                                    'productId': orderValue.productId,
                                    'title': orderValue.title,
                                    'price':
                                        orderValue.price * orderValue.quantity,
                                    'imageUrl': orderValue.imageUrl,
                                    'quantity': orderValue.quantity,
                                    'orderDate': Timestamp.now(),
                                  });
                                } catch (err) {
                                  print('error occured $err');
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                    Fluttertoast.showToast(
                                        msg: "Order Placed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    cartProvider.clearCart();
                                  });
                                }
                              });
                            },
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
                      'US \$${total.toStringAsFixed(2)}',
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
