import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_default_code/screens/product_details.dart';

class FeedsProducts extends StatefulWidget {
  const FeedsProducts(
      {Key? key,
        required this.id,
        required this.description,
        required this.price,
        required this.imageUrl,
        required this.quantity,
        required this.isFavourite})
      : super(key: key);
  final String id;
  final String description;
  final double price;
  final String imageUrl;
  final int quantity;
  final bool isFavourite;

  @override
  _FeedsProductsState createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName),
      child: Container(
        width: 250,
        height: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      // bottom: 0,
                      // right: 5,
                      // top: 5,
                      child: Badge(
                        alignment: Alignment.center,
                        toAnimate: true,
                        shape: BadgeShape.square,
                        badgeColor: Colors.pink,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8)),
                        badgeContent:
                            Text('New', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '\$ ${widget.price}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.quantity}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () async {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => FeedDialog(
                              //     productId: productsAttributes.id,
                              //   ),
                              // );
                            },
                            borderRadius: BorderRadius.circular(18.0),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
