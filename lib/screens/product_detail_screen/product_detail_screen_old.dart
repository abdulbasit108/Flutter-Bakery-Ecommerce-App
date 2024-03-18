import 'dart:math';

import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/screens/product_detail_screen/product_page.dart';
import 'package:bakeway_app/screens/widget/round_button.dart';
import 'package:bakeway_app/shared_components/section_heading/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../Bloc/CartBloc/cart_bloc.dart';

class ProductScreen extends StatefulWidget {
  final String imageUrl;
  final String productDesc, productName, productVendor, productPrice;
  void Function() onTap;

  ProductScreen(
      {required this.imageUrl,
      required this.productName,
      required this.productVendor,
      required this.productPrice,
      required this.productDesc,
      required this.onTap});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

Random rand = Random();

class _ProductScreenState extends State<ProductScreen> {
  double value = rand.nextDouble() * 3 + 2;
  double selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ListView(children: [
      Column(children: <Widget>[
        Hero(
          tag: widget.imageUrl,
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
          ),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              width: _width,
              // height: _height * 0.1,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(title: widget.productName),
                      Text.rich(
                        TextSpan(
                          text: 'Baked By ',
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.productVendor,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDefaultColor),
                            ),
                          ],
                        ),
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
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: kDefaultColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      Text(
                        'PKR',
                        style: TextStyle(
                            color: kDefaultColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.productPrice,
                        style: TextStyle(
                          // color: kDefaultColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeading(title: 'About Product'),
                  Text(
                    widget.productDesc,
                  ),
                ],
              ),
            ),
            Text(
              'Do You Want To Order?',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            RoundButton(title: 'Order Now', onTap: widget.onTap),
          ],
        )
      ])
    ]));
  }
}
