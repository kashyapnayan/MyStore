import 'package:backdrop/backdrop.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_default_code/provider/products.dart';
import 'package:flutter_default_code/widgets/backlayer.dart';
import 'package:flutter_default_code/widgets/category.dart';
import 'package:flutter_default_code/widgets/popular_products.dart';
import 'package:provider/provider.dart';

import 'feeds.dart';
import 'inner_screens/brands_navigation_rail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [
    'assets/carousel1.png',
    'assets/carousel2.jpeg',
    'assets/carousel3.jpg',
    'assets/carousel4.png',
  ];

  List<String> _brandImages = [
    'assets/addidas.jpg',
    'assets/apple.jpg',
    'assets/Dell.jpg',
    'assets/h&m.jpg',
    'assets/nike.jpg',
    'assets/samsung.jpg',
    'assets/Huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final popularProducts = productsProvider.popularProducts;
    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerHeight: MediaQuery.of(context).size.height * 0.25,
      appBar: BackdropAppBar(
        title: Text("Home"),
        leading: BackdropToggleButton(
          icon: AnimatedIcons.home_menu,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorsConsts.starterColor,
              ColorsConsts.endColor
            ])
          ),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 15,
            onPressed: (){},
            padding: const EdgeInsets.all(10),
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 13,
                backgroundImage: NetworkImage(
                    'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'
                ),
              ),
            ),
          )
        ],
      ),
      backLayer: BackLayerMenu(),
      frontLayer: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 190,
                pageSnapping: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
              ),
                items: <Widget>[
                  for (var i = 0; i < _carouselImages.length; i++)
                    Image.asset(
                        _carouselImages[i],
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context)
                            .size
                            .width)
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),
              ),
            ),

            Container(
              height: 180,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int position){
                    return CategoryWidget(
                      index: position,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Brands',
                    style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(
                        BrandNavigationRailScreen.routeName,
                        arguments: {
                          7,
                        },
                      );
                    },
                    child: Text('View All',
                      style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width * .95,
              child: Swiper(
                itemHeight: 200,
                itemBuilder: (BuildContext context,int index){
                  return Image.asset(_brandImages[index],fit: BoxFit.fill,);
                },
                onTap :(index){
                  Navigator.of(context).pushNamed(
                    BrandNavigationRailScreen.routeName,
                    arguments: {
                      index,
                    },
                  );
                },
                outer: true,
                viewportFraction: 0.8,
                scale: 0.9,
                itemCount: _brandImages.length,
                control: SwiperControl(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),
                  ),
                  TextButton(
                    onPressed: ()=> Navigator.pushNamed(context, Feeds.routeName,arguments: 'popular'),
                    child: Text('View All',
                      style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 285,
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts.length,
                  itemBuilder: (BuildContext context, int index){
                    return ChangeNotifierProvider.value(
                        value: popularProducts[index],
                        child: PopularProducts());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
