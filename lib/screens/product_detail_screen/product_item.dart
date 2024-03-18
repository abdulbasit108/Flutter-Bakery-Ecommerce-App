import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../constants/color_constants/color_constants.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.productImage,
    required this.title,
    required this.price,
    required this.press,
    required this.addToCart,
    required this.productVendor,
  }) : super(key: key);
  final String productImage, title, productVendor;
  final int price;
  final void Function()? press;
  final void Function()? addToCart;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

Random rand = Random();

class _ProductItemState extends State<ProductItem> {
  double value = rand.nextDouble() * 3 + 2;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: widget.press,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              //color: Colors.amber,
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
              width: _width * 0.45,
              height: _height * 0.28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.productImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.productImage,
                        fit: BoxFit.values[0],
                        height: _height * 0.313 / 2,
                        width: _width * 0.45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Baked by ${widget.productVendor}',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingStars(
                    value: value,
                    onValueChanged: (v) {
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
                    animationDuration: Duration(milliseconds: 1000),
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
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
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
                'PKR ${widget.price}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
