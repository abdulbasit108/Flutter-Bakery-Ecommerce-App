import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

//TODO : Wrap Containers with InkWell and apply function required paramaeter for function passing as argument.

AppBar buildAppBar(double _width) {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  return AppBar(
    backgroundColor: kDefaultColor,
    leading: IconButton(
      onPressed: _handleMenuButtonPressed,
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: _advancedDrawerController,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: Icon(
              value.visible ? Icons.clear : Icons.menu,
              key: ValueKey<bool>(value.visible),
            ),
          );
        },
      ),
    ),
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('HOME'),
        SizedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  // color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(300)),
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Text(
        //   'Bakeway',
        //   style: TextStyle(color: Colors.red),
        // ),
      ],
    ),
    // actions: [Icon(ba)],
  );
}
