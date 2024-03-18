import 'package:bakeway_app/screens/product_detail_screen/item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bakeway_app/model/shop.dart';
import 'package:bakeway_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/color_constants/color_constants.dart';
import '../../shared_components/section_heading/section_heading.dart';
import '../home_screen/components/category_button/category_button.dart';
import 'product_detail.dart';
import 'product_item.dart';
import 'package:bakeway_app/screens/order_summary_screen/cart_screen.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  _ProductPageState createState() => _ProductPageState();
}

Future<List<ShopItem>> loadShopItemsFromFirestore() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('products').get();

  List<ShopItem> shopItems = [];

  if (querySnapshot.docs.isNotEmpty) {
    querySnapshot.docs.forEach((doc) {
      ShopItem shopItem = ShopItem.fromFirestore(doc);
      shopItems.add(shopItem);
    });
  }

  return shopItems;
}

class _ProductPageState extends State<ProductPage> {
  bool loadingData = true;
  List<ShopItem> _cartItems = [];
  late List<ShopItem> _shopItems = [];
  late List<ShopItem> categoryItems = [];
  String title = '';
  final searchController = TextEditingController();
  final priceFromController = TextEditingController();
  final priceToController = TextEditingController();
  double priceFrom = 0;
  double priceTo = 999999;

  void _buildItemsList(String category) {
    categoryItems = _shopItems
        .where((shopItems) => shopItems.category == category)
        .toList();
  }

  void _buildSearchList(String search) {
    categoryItems =
        _shopItems.where((shopItems) => shopItems.title == search).toList();
  }

  Future<void> _loadData() async {
    List<ShopItem> shopItems = await loadShopItemsFromFirestore();

    setState(() {
      _shopItems = shopItems;
    });

    _buildItemsList(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ShopInitial) {
          loadingData = true;
        } else if (state is ShopPageLoadedState) {
          _loadData();
          _buildItemsList(widget.category);
          title = widget.category;
          //_cartItems = state.cartData.shopitems;
          loadingData = false;
        }
        if (state is ItemAddedCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
        if (state is ItemDeletingCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          print("produc page state: $state");

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kDefaultColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("BAKEWAY"),
                  SizedBox(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              //Navigator.pushNamed(context, '/order-summary');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<ShopBloc>(
                                              context),
                                          child: CartScreen())));
                            },
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            // color: Colors.white,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(300)),
                            child: Text(
                              _cartItems.length.toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: kDefaultColor,
            //   onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => BlocProvider.value(
            //             value: BlocProvider.of<ShopBloc>(context),
            //             child: CartScreen())));
            //   },
            //   child: Text(
            //     _cartItems.length.toString(),
            //   ),
            // ),
            body: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          hintText: 'Search here',
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (searchController.text != '') {
                                setState(() {
                                  _buildSearchList(searchController.text);
                                  searchController.clear();
                                });
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: kDefaultColor,
                            ),
                          ),
                          hintStyle:
                              TextStyle(letterSpacing: 2, color: kDefaultColor),
                          contentPadding: const EdgeInsets.only(
                            left: 14.0,
                            bottom: 8.0,
                            top: 12.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kDefaultColor,
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextField(
                                controller: priceFromController,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  hintText: 'Price From',
                                  hintStyle: TextStyle(
                                      letterSpacing: 2, color: kDefaultColor),
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                    bottom: 8.0,
                                    top: 12.0,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: kDefaultColor,
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('-'),
                          ),
                          Flexible(
                            child: TextField(
                                controller: priceToController,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  hintText: 'Price To',
                                  hintStyle: TextStyle(
                                      letterSpacing: 2, color: kDefaultColor),
                                  contentPadding: const EdgeInsets.only(
                                    left: 14.0,
                                    bottom: 8.0,
                                    top: 12.0,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: kDefaultColor,
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                if (priceFromController.text == '' &&
                                    priceToController.text == '') {
                                } else if (priceFromController.text == '' &&
                                    priceToController.text != '') {
                                  setState(() {
                                    categoryItems = categoryItems
                                        .where((element) =>
                                            element.price <=
                                            double.parse(
                                                priceToController.text))
                                        .toList();
                                    priceToController.clear();
                                  });
                                } else if (priceFromController.text != '' &&
                                    priceToController.text == '') {
                                  setState(() {
                                    categoryItems = categoryItems
                                        .where((element) =>
                                            element.price >=
                                            double.parse(
                                                priceFromController.text))
                                        .toList();
                                    priceFromController.clear();
                                  });
                                } else if (priceFromController.text != '' &&
                                    priceToController.text != '') {
                                  setState(() {
                                    categoryItems = categoryItems
                                        .where((element) =>
                                            element.price >=
                                                double.parse(
                                                    priceFromController.text) &&
                                            element.price <=
                                                double.parse(
                                                    priceToController.text))
                                        .toList();
                                    priceFromController.clear();
                                    priceToController.clear();
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.price_change_outlined,
                                color: kDefaultColor,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: SectionHeading(title: 'Categories'),
                      margin:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _buildItemsList('Biscuit');
                                  title = 'Biscuit';
                                });
                              },
                              child: CategoryButton(
                                width: _width,
                                height: _height,
                                icon: FontAwesomeIcons.cookieBite,
                                buttonColor: kDefaultColor,
                                buttonText: 'Biscuit',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _buildItemsList('Cakes');
                                  title = 'Cakes';
                                });
                              },
                              child: CategoryButton(
                                width: _width,
                                height: _height,
                                icon: FontAwesomeIcons.cakeCandles,
                                buttonColor: kDefaultContrastColor,
                                buttonText: 'Cakes',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _buildItemsList('Bread');
                                  title = 'Bread';
                                });
                              },
                              child: CategoryButton(
                                width: _width,
                                height: _height,
                                icon: FontAwesomeIcons.breadSlice,
                                buttonColor: kDefaultColor,
                                buttonText: 'Bread',
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _buildItemsList('Rusks');
                                    title = 'Rusks';
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 32),
                                        decoration: BoxDecoration(
                                          color: kDefaultContrastColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: _width * 0.15,
                                        height: _height * 0.066,
                                        child: ImageIcon(
                                          AssetImage('assets/images/rusk.png'),
                                          color: Colors.white,
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: _width * 0.16,
                                      child: Text(
                                        'RUSKS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _buildItemsList('Donuts');
                                    title = 'Donuts';
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 32),
                                        decoration: BoxDecoration(
                                          color: kDefaultColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: _width * 0.15,
                                        height: _height * 0.066,
                                        child: ImageIcon(
                                          AssetImage(
                                              'assets/images/Donuts.png'),
                                          color: Colors.white,
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: _width * 0.16,
                                      child: Text(
                                        'DONUTS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _buildItemsList('Snacks');
                                    title = 'Snacks';
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 32),
                                        decoration: BoxDecoration(
                                          color: kDefaultContrastColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: _width * 0.15,
                                        height: _height * 0.066,
                                        child: ImageIcon(
                                          AssetImage('assets/images/snack.png'),
                                          color: Colors.white,
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: _width * 0.16,
                                      child: Text(
                                        'SNACKS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _buildItemsList('Sweets');
                                    title = 'Sweets';
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 32),
                                        decoration: BoxDecoration(
                                          color: kDefaultColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: _width * 0.15,
                                        height: _height * 0.066,
                                        child: ImageIcon(
                                          AssetImage(
                                              'assets/images/Sweets.png'),
                                          color: Colors.white,
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: _width * 0.16,
                                      child: Text(
                                        'SWEETS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: SectionHeading(title: title),
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                ),
                ItemList(
                    loadingData: loadingData,
                    cartItems: _cartItems,
                    categoryItems: categoryItems)
                // loadingData
                //     ? Center(
                //         child: Center(
                //         child: CircularProgressIndicator(),
                //       ))
                //     : SingleChildScrollView(
                //         child: Column(
                //           children: [
                //             Stack(
                //               children: [
                //                 Container(
                //                   // height: displayHeight(context) * 6,

                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       SizedBox(height: 20),

                //                       GridView.builder(
                //                           gridDelegate:
                //                               SliverGridDelegateWithFixedCrossAxisCount(
                //                             crossAxisCount: 2,
                //                             childAspectRatio: 0.8,
                //                             mainAxisSpacing: 5,
                //                             crossAxisSpacing: 5,
                //                           ),
                //                           itemCount: categoryItems.length,
                //                           shrinkWrap: true,
                //                           physics:
                //                               NeverScrollableScrollPhysics(),
                //                           itemBuilder: (context, index) {
                //                             return ProductItem(
                //                               addToCart: () {
                //                                 setState(() {
                //                                   _cartItems.add(
                //                                       categoryItems[index]);
                //                                 });

                //                                 print("added");
                //                               },
                //                               // productImage:
                //                               //     shopItems[index].imageUrl,
                //                               productImage: categoryItems[index]
                //                                   .thumbnail,
                //                               price: categoryItems[index].price,
                //                               title: categoryItems[index].title,
                //                               productVendor:
                //                                   categoryItems[index]
                //                                       .productVendor,
                //                               press: () {
                //                                 Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                         builder: (_) =>
                //                                             BlocProvider.value(
                //                                                 value: BlocProvider
                //                                                     .of<ShopBloc>(
                //                                                         context)
                //                                                   ..add(ItemAddingCartEvent(
                //                                                       cartItems:
                //                                                           _cartItems)),
                //                                                 child:
                //                                                     ProductDetail(
                //                                                   shopItem:
                //                                                       categoryItems[
                //                                                           index],
                //                                                 ))));
                //                               },
                //                             );
                //                           })

                // GridView.builder(
                //     gridDelegate:
                //         SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       childAspectRatio: 0.8,
                //       mainAxisSpacing: 5,
                //       crossAxisSpacing: 5,
                //     ),
                //     itemCount: shopItems.length,
                //     shrinkWrap: true,
                //     physics:
                //         NeverScrollableScrollPhysics(),
                //     itemBuilder: (context, index) {
                //       return ProductItem(
                //         addToCart: () {
                //           setState(() {
                //             _cartItems
                //                 .add(shopItems[index]);
                //           });

                //           print("added");
                //         },
                //         // productImage:
                //         //     shopItems[index].imageUrl,
                //         productImage:
                //             shopItems[index].thumbnail,
                //         price: shopItems[index].price,
                //         title: shopItems[index].title,
                //         productVendor: shopItems[index]
                //             .productVendor,
                //         press: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (_) =>
                //                       BlocProvider.value(
                //                           value: BlocProvider
                //                               .of<ShopBloc>(
                //                                   context)
                //                             ..add(ItemAddingCartEvent(
                //                                 cartItems:
                //                                     _cartItems)),
                //                           child:
                //                               ProductDetail(
                //                             shopItem:
                //                                 shopItems[
                //                                     index],
                //                           ))));
                //         },
                //       );
                //     }),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
