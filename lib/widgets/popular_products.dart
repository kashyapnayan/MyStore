import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                10.0,
              ),
              bottomRight: Radius.circular(10.0),
            ),
            onTap: (){},
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('https://i.gadgets360cdn.com/products/large/realme-watch-670x800-1590388807.jpg'),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Ionicons.star,
                        color: Colors.red
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Ionicons.star_outline,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ 60',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product title',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Description',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){},
                                borderRadius: BorderRadius.circular(30.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}