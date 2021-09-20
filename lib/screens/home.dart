import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:ionicons/ionicons.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
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
                  'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'
                ),
              ),
            ),
          )
        ],
      ),
      backLayer: Center(
        child: Text("Back Layer"),
      ),
      frontLayer: Center(
        child: Text("Front Layer"),
      ),
    );
  }
}
