import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bakeway_app/screens/order_summary_screen/cart_screen.dart';
import 'package:bakeway_app/model/shop.dart';
import 'package:bakeway_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../constants/color_constants/color_constants.dart';
import '../../shared_components/section_heading/section_heading.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.shopItem}) : super(key: key);

  final ShopItem shopItem;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

Random rand = Random();

class _ProductDetailState extends State<ProductDetail> {
  List<ShopItem> cartItems = [];
  double value = rand.nextDouble() * 3 + 2;
  String selectedValue = '1 Pound';
  // double mutliplyFactor =

  // List<DropdownMenuItem> weightOfCakes = const [
  //   DropdownMenuItem(
  //     value: 1,
  //     child: Text("1 Pound"),
  //   ),
  //   DropdownMenuItem(
  //     value: 2,
  //     child: Text("2 pound"),
  //   ),
  //   DropdownMenuItem(
  //     value: 3,
  //     child: Text("3 Pound"),
  //   ),
  //   DropdownMenuItem(
  //     value: 4,
  //     child: Text("4 Pound"),
  //   ),
  // ];

  bool _itemselected = false;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {},
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ItemAddingCartState) {
            cartItems = state.cartItems;
          }

          return Scaffold(
              backgroundColor: Colors.white,

              // appBar: AppBar(
              //   leading: IconButton(
              //     icon: Icon(Icons.arrow_back_ios),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              //   title: Text(
              //     "E-com",
              //   ),
              //   elevation: 0,
              //   backgroundColor: Colors.orange,
              // ),
              body: ListView(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: widget.shopItem.imageUrl,
                        child: Image.network(
                          widget.shopItem.imageUrl,
                          fit: BoxFit.values[0],
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: 0.2,
                              child: Container(
                                width: 90,
                                height: 40,
                                margin: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                  color: kDefaultColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_sharp,
                                        color: kDefaultColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //     color: kDefaultColor,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(10),
                              //       bottomRight: Radius.circular(10),
                              //     ),
                              //   ),
                              //   child: Padding(
                              //     padding: EdgeInsets.only(right: 10),
                              //     child: Align(
                              //       alignment: Alignment.centerRight,
                              //       child: CircleAvatar(
                              //         backgroundColor: Colors.white,
                              //         radius: 20,
                              //         child: IconButton(
                              //           icon: Icon(
                              //             Icons.arrow_back,
                              //             color: Colors.black,
                              //           ),
                              //           onPressed: () {
                              //             Navigator.pop(context);
                              //           },
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, -_width * 0.07),
                        child: Container(
                          width: _width * 0.34,
                          height: _height * 0.07,
                          decoration: BoxDecoration(
                            color: kDefaultColor,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  if (widget.shopItem.quantity > 0)
                                    setState(() {
                                      widget.shopItem.quantity--;
                                    });
                                },
                              ),
                              SizedBox(
                                height: 35,
                                width: 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      widget.shopItem.quantity.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 22)),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    widget.shopItem.quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        width: _width,
                        height: _height * 0.13,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionHeading(title: widget.shopItem.title),
                                SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: 'Baked By ',
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.shopItem.productVendor,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kDefaultColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
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
                                  animationDuration:
                                      Duration(milliseconds: 1000),
                                  valueLabelPadding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 8),
                                  valueLabelMargin:
                                      const EdgeInsets.only(right: 8),
                                  starOffColor: const Color(0xffe7e8ea),
                                  starColor: kDefaultColor,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: kDefaultColor,
                                  ),
                                  child: DropdownButton<String>(
                                    style: TextStyle(color: Colors.white),
                                    dropdownColor: kDefaultColor,
                                    value: selectedValue,
                                    underline: SizedBox(),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    //  hint: Text('Select Category', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),

                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '1 Pound',
                                      '2 Pound',
                                      '3 Pound',
                                      '4 Pound'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),

                                  // DropdownButton(
                                  //   style: TextStyle(color: Colors.white),
                                  //   dropdownColor: kDefaultColor,
                                  //   value: selectedValue,
                                  //   underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.arrow_drop_down,
                                  //   color: Colors.white,
                                  // ),
                                  //   items: weightOfCakes,
                                  //   onChanged: (newValue) {
                                  //     selectedValue = newValue;
                                  //     print(selectedValue);
                                  //     // value:
                                  //     // selectedValue;
                                  //   },

                                  //   // dropdownColor: Colors.blueAccent,
                                  //   // value: selectedValue,
                                  // ),
                                ),
                                // const SizedBox(
                                //   height: 12,
                                // ),
                                Text(
                                  'PKR',
                                  style: TextStyle(
                                      color: kDefaultColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${widget.shopItem.price * int.parse(selectedValue.substring(0, 1))}',
                                  style: TextStyle(
                                    // color: kDefaultColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeading(title: 'About Product'),
                            Text(widget.shopItem.detail),
                          ],
                        ),
                      ),
                      Text(
                        'Special Instructions',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 15),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          width: _width,
                          height: _height * 0.065,
                          // color: Colors.pink,
                          decoration: BoxDecoration(
                            border: Border.all(color: kDefaultColor, width: 2),
                          ),
                          child: TextField(
                              decoration: InputDecoration(
                                  labelText: ' eg. Write Happy Birthday'))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: InkWell(
                          onTap: () {
                            if (_itemselected == false) {
                              ShopItem cartItem = ShopItem(
                                  imageUrl: widget.shopItem.imageUrl,
                                  title: widget.shopItem.title,
                                  detail: widget.shopItem.detail,
                                  category: widget.shopItem.category,
                                  productVendor: widget.shopItem.productVendor,
                                  price: widget.shopItem.price *
                                      int.parse(selectedValue.substring(0, 1)),
                                  quantity: widget.shopItem.quantity,
                                  weight: widget.shopItem.weight);

                              cartItems.add(cartItem);

                              BlocProvider.of<ShopBloc>(context)
                                ..add(ItemAddedCartEvent(cartItems: cartItems));

                              setState(() {
                                _itemselected = true;
                              });
                            } else
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<ShopBloc>(context),
                                    child: CartScreen(),
                                  ),
                                ),
                              );
                          },
                          child: Center(
                            child: Container(
                              width: _width * 0.55,
                              height: _height * 0.07,
                              decoration: BoxDecoration(
                                color: kDefaultContrastColor,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Center(
                                child: Text(
                                  _itemselected
                                      ? 'Go to Cart'.toUpperCase()
                                      : 'Add to Cart'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: TextButton(
                        //       onPressed: () {
                        //         if (_itemselected == false) {
                        //           ShopItem cartItem = ShopItem(
                        //               imageUrl: widget.shopItem.imageUrl,
                        //               thumbnail: widget.shopItem.thumbnail,
                        //               title: widget.shopItem.title,
                        //               detail: widget.shopItem.detail,
                        //               category: widget.shopItem.category,
                        //               productVendor:
                        //                   widget.shopItem.productVendor,
                        //               price: widget.shopItem.price,
                        //               quantity: widget.shopItem.quantity,
                        //               weight: widget.shopItem.weight);

                        //           cartItems.add(cartItem);

                        //           BlocProvider.of<ShopBloc>(context)
                        //             ..add(ItemAddedCartEvent(
                        //                 cartItems: cartItems));

                        //           setState(() {
                        //             _itemselected = true;
                        //           });
                        //         } else
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (_) => BlocProvider.value(
                        //                 value:
                        //                     BlocProvider.of<ShopBloc>(context),
                        //                 child: CartScreen(),
                        //               ),
                        //             ),
                        //           );
                        //       },
                        //       child: Text(
                        //         _itemselected ? 'Go to Cart' : 'Add to Cart',
                        //         style: TextStyle(color: Colors.black),
                        //       )),
                        // ),
                      ),
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
