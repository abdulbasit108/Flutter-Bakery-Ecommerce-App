import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../../constants/color_constants/color_constants.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required double width,
      required double height,
      required this.onPressed,
      required this.imagePath,
      required this.productName,
      required this.productVendor,
      required this.productPrice})
      : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;
  final Function() onPressed;
  final String imagePath, productName, productVendor, productPrice;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

Random rand = Random();

class _ProductCardState extends State<ProductCard> {
  double value = rand.nextDouble() * 3 + 2;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Stack(
        children: [
          Container(
            // color: Colors.red,
            // alignment: Alignment.center,
            // padding: EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            width: widget._width * 0.45,
            height: widget._height * 0.313,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.imagePath,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.imagePath,
                      fit: BoxFit.values[0],
                      height: widget._height * 0.313 / 2,
                      width: widget._width * 0.45,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Baked by ${widget.productVendor}',
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    //
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: kDefaultColor,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            width: 90,
            height: 35,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: kDefaultColor,
            ),
            child: Text(
              widget.productPrice,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
