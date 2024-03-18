import 'package:flutter/material.dart';

import '../../constants/color_constants/color_constants.dart';

class DecoratedTextField extends StatelessWidget {
  const DecoratedTextField(
      {Key? key,
      required double width,
      required double height,
      required this.icon,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.validator})
      : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;
  final Widget icon;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height * 0.07,
      margin: EdgeInsets.symmetric(vertical: 19),
      decoration: BoxDecoration(
        color: kDefaultColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: kDefaultColor,
            blurRadius: 2,
            offset: Offset(0, 2.5),
            // TODO : Extract a reusable widget....for this.
          ),
        ],
      ),
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: _width * 0.19,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: icon,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              obscureText: obscureText,
              style: TextStyle(color: Colors.white),
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kDefaultColor),
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
