import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/screens/home_screen/home_screen.dart';
import 'package:bakeway_app/screens/order_summary_screen/cart_screen.dart';
import 'package:bakeway_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int selectedIndex = 0;
  bool _colorful = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 1:
          Navigator.pushNamed(context, '/order-recent');
          break;
        case 2:
          Navigator.pushNamed(context, '/profile-screen');
          break;
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _listOfWidget,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_travel), label: 'Order'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          // selectedItemColor: Colors.amber[800],
          onTap: onButtonPressed,
          backgroundColor: kDefaultColor,
          iconSize: 30,
          selectedItemColor: Colors.white,
          //selectedItemColor: Colors.white,
        )
        
        );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  HomeScreen(),
  CartScreen(),
  ProfileScreen()
];
