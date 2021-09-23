import 'package:flutter/material.dart';
import 'package:flutter_default_code/screens/feeds.dart';
import 'package:flutter_default_code/screens/inner_screens/categories_feeds.dart';

class CategoryWidget extends StatefulWidget {
  final int index;
  const CategoryWidget({Key? key, required this.index}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  var categories;
  @override
  void initState() {
    super.initState();
    categories = [
      {'categoryName': 'Phones', 'categoryImagesPath': 'assets/CatPhones.png'},
      {'categoryName': 'Beauty', 'categoryImagesPath': 'assets/CatBeauty.jpg'},
      {
        'categoryName': 'Clothes',
        'categoryImagesPath': 'assets/CatClothes.jpg'
      },
      {
        'categoryName': 'Furniture',
        'categoryImagesPath': 'assets/CatFurniture.jpg'
      },
      {
        'categoryName': 'Laptops',
        'categoryImagesPath': 'assets/CatLaptops.png'
      },
      {'categoryName': 'Shoes', 'categoryImagesPath': 'assets/CatShoes.jpg'},
      {
        'categoryName': 'Watches',
        'categoryImagesPath': 'assets/CatWatches.jpg'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, CategoriesFeeds.routeName,
                arguments: categories[widget.index]['categoryName']);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                      categories[widget.index]['categoryImagesPath']),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
