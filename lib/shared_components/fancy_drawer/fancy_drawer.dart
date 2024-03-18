// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../constants/color_constants/color_constants.dart';
// import '../../screens/home_screen/components/category_button/category_button.dart';
// import '../../screens/home_screen/components/product_card/product_card.dart';
// import '../../screens/product_detail_screen/product_detail_screen.dart';
// import '../section_heading/section_heading.dart';
//
// class HomeScreen1 extends StatefulWidget {
//   @override
//   _HomeScreen1State createState() => _HomeScreen1State();
// }
//
// class _HomeScreen1State extends State<HomeScreen1> {
//   final _advancedDrawerController = AdvancedDrawerController();
//
//   @override
//   Widget build(BuildContext context) {
//     final _width = MediaQuery.of(context).size.width;
//     final _height = MediaQuery.of(context).size.height;
//     return AdvancedDrawer(
//       backdropColor: kDefaultContrastColor,
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       // openScale: 1.0,
//       disabledGestures: false,
//       childDecoration: const BoxDecoration(
//         // NOTICE: Uncomment if you want to add shadow behind the page.
//         // Keep in mind that it may cause animation jerks.
//         // boxShadow: <BoxShadow>[
//         //   BoxShadow(
//         //     color: Colors.black12,
//         //     blurRadius: 0.0,
//         //   ),
//         // ],
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Scaffold(
//         appBar: buildAppBarAdvanced(),
//         body: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: kDefaultColor,
//                     //TODO : Wait for wajih approval
//                     // borderRadius: BorderRadius.circular(25),
//                     // boxShadow: [
//                     //   BoxShadow(
//                     //       color: kDefaultColor,
//                     //       blurRadius: 10,
//                     //       offset: Offset(-1, 2))
//                     // ],
//                   ),
//                   // color: kDefaultColor,
//                   // width: _width * 0.55,
//                   // color: Colors.red,
//                   child: TextField(
//                     controller: TextEditingController(),
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Search here',
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: kDefaultColor,
//                       ),
//                       hintStyle:
//                           TextStyle(letterSpacing: 2, color: kDefaultColor),
//                       contentPadding: const EdgeInsets.only(
//                         left: 14.0,
//                         bottom: 8.0,
//                         top: 12.0,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: kDefaultColor,
//                         ),
//                         // borderRadius: BorderRadius.circular(25),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: const BorderSide(color: kDefaultColor),
//                         // borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
//                   padding: EdgeInsets.all(8),
//                   width: double.infinity,
//                   height: _height * 0.187,
//                   decoration: BoxDecoration(
//                     color: kDefaultContrastColor,
//                     borderRadius: BorderRadius.circular(22),
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 3,
//                         offset: Offset(0, 1.5),
//                       ),
//                     ],
//                   ),
//                   child: Image.asset('assets/images/Banner.jpg'),
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                     child: Row(
//                       children: [
//                         CategoryButton(
//                           width: _width,
//                           height: _height,
//                           icon: FontAwesomeIcons.cookieBite,
//                           buttonColor: kDefaultColor,
//                           buttonText: 'biscuits',
//                         ),
//                         CategoryButton(
//                           width: _width,
//                           height: _height,
//                           icon: FontAwesomeIcons.cake,
//                           buttonColor: kDefaultContrastColor,
//                           buttonText: 'pastry',
//                         ),
//                         CategoryButton(
//                           width: _width,
//                           height: _height,
//                           icon: FontAwesomeIcons.cakeCandles,
//                           buttonColor: kDefaultColor,
//                           buttonText: 'cakes',
//                         ),
//                         CategoryButton(
//                           width: _width,
//                           height: _height,
//                           icon: FontAwesomeIcons.breadSlice,
//                           buttonColor: kDefaultContrastColor,
//                           buttonText: 'bread',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 15),
//                   child: const SectionHeading(
//                     title: 'Popular Items',
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ProductCard(
//                       width: _width,
//                       height: _height,
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductScreen(
//                               title: 'TEst',
//                               imageUrl:
//                                   'https://images.pexels.com/photos/132694/pexels-photo-132694.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//                             ),
//                           ),
//                         );
//                       },
//                       imagePath:
//                           'https://images.pexels.com/photos/132694/pexels-photo-132694.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//                       productName: 'Chocolate Cake',
//                       productVendor: 'Kababjees',
//                     ),
//                     ProductCard(
//                       width: _width,
//                       height: _height,
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductScreen(
//                               title: 'TEst',
//                               imageUrl:
//                                   'https://images.pexels.com/photos/1414234/pexels-photo-1414234.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//                             ),
//                           ),
//                         );
//                       },
//                       imagePath:
//                           'https://images.pexels.com/photos/1414234/pexels-photo-1414234.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//                       productName: 'Chocolate Cake',
//                       productVendor: 'Kababjees',
//                     ),
//                     // ProductCard(
//                     //   width: _width,
//                     //   height: _height,
//                     //   onPressed: () {},
//                     //   imagePath: 'assets/images/cake1.jpg',
//                     //   productName: 'Chocolate Cake',
//                     //   productVendor: 'Kababjees',
//                     // ),
//                     //TODO : List Tile should be implemented here.......
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       drawer: SafeArea(
//         child: Container(
//           child: ListTileTheme(
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(
//                   width: 128.0,
//                   height: 128.0,
//                   margin: const EdgeInsets.only(
//                     top: 24.0,
//                     bottom: 64.0,
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: Colors.black26,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.network(
//                     'https://static.wikia.nocookie.net/ben10/images/d/d2/Alien_X_One_Omnitrix.png/revision/latest?cb=20220802064438',
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.home),
//                   title: Text('Home'),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     //TODO: Shipping address navigator here.
//                     print('object');
//                     Navigator.pushNamed(context, '/shipping-screen');
//                   },
//                   leading: Icon(FontAwesomeIcons.addressCard),
//                   title: Text('Shipping Address'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.history),
//                   title: Text('Order History'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.settings),
//                   title: Text('Settings'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.logout),
//                   title: Text('Logout'),
//                 ),
//                 Spacer(),
//                 DefaultTextStyle(
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white54,
//                   ),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 16.0,
//                     ),
//                     child: Text('Terms of Service | Privacy Policy'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   AppBar buildAppBarAdvanced() {
//     return AppBar(
//       title: const Text('Advanced Drawer Example'),
//       backgroundColor: kDefaultColor,
//       leading: IconButton(
//         onPressed: _handleMenuButtonPressed,
//         icon: ValueListenableBuilder<AdvancedDrawerValue>(
//           valueListenable: _advancedDrawerController,
//           builder: (_, value, __) {
//             return AnimatedSwitcher(
//               duration: Duration(milliseconds: 250),
//               child: Icon(
//                 value.visible ? Icons.clear : Icons.menu,
//                 key: ValueKey<bool>(value.visible),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _handleMenuButtonPressed() {
//     // NOTICE: Manage Advanced Drawer state through the Controller.
//     // _advancedDrawerController.value = AdvancedDrawerValue.visible();
//     _advancedDrawerController.showDrawer();
//   }
// }
