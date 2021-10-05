import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/provider/orders_provider.dart';
import 'package:provider/provider.dart';

import 'order_empty.dart';
import 'orders_data.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    // print('orderProvider.getOrders length ${orderProvider.getOrders.length}');
    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.getOrders.isEmpty
              ? Scaffold(body: OrderEmpty())
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Orders (${orderProvider.getOrders.length})'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          // globalMethods.showDialogg(
                          //     'Clear cart!',
                          //     'Your cart will be cleared!',
                          //     () => cartProvider.clearCart(),
                          //     context);
                        },
                        icon: Icon(MyAppIcons.trash),
                      )
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        itemCount: orderProvider.getOrders.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                              value: orderProvider.getOrders[index],
                              child: OrdersData());
                        }),
                  ));
        });
  }
}
