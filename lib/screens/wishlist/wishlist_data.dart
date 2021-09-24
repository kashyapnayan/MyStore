import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:flutter_default_code/models/fav_attributes.dart';
import 'package:flutter_default_code/provider/fav_provider.dart';
import 'package:flutter_default_code/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../product_details.dart';

class WishlistData extends StatefulWidget {
  final String productId;
  const WishlistData({Key? key,required this.productId}) : super(key: key);

  @override
  _WishlistDataState createState() => _WishlistDataState();
}

class _WishlistDataState extends State<WishlistData> {
  @override
  Widget build(BuildContext context) {
    final favsAttr = Provider.of<FavAttributes>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
                  arguments: widget.productId),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favsAttr.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${favsAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId),
      ],
    );
  }

  Widget positionedRemove(String productId) {
    final favProvider = Provider.of<FavProvider>(context);
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(0.0),
            color: ColorsConsts.favColor,
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () => {
              GlobalMethods.showTheDialog(
                  'Remove wish!',
                  'This product will be removed from your wishlist!',
                      () => favProvider.removeItem(productId),
                  context),
            }),
      ),
    );
  }
}
