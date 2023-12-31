
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:day53/bottomnabbar/category.dart';
import 'package:day53/bottomnabbar/orderpage.dart';
import 'package:day53/bottomnabbar/product.dart';
import 'package:day53/bottomnabbar/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavBarDemo extends StatefulWidget {
  const BottomNavBarDemo({super.key});

  @override
  State<BottomNavBarDemo> createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List mypage = [
      OrderPage(),
      Category(),
      Product(),
      Profile(),

    ];
    //int _page = 0;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          //index: 0,
          height: 60.0,
          items: [
            //Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.category_outlined, size: 30),
            // Icon(Icons.call_split, size: 30),
            Icon(Icons.production_quantity_limits_outlined, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),

          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: mypage.elementAt(_page));
    // mypage[_page]);
  }
}
