import 'package:bakeway_app/model/shop.dart';
import 'package:bakeway_app/screens/product_detail_screen/product_detail.dart';
import 'package:bakeway_app/screens/product_detail_screen/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/CartBloc/cart_bloc.dart';

class ItemList extends StatefulWidget {
  const ItemList(
      {super.key,
      required this.loadingData,
      required this.cartItems,
      required this.categoryItems});
  final bool loadingData;
  final List<ShopItem> cartItems;
  final List<ShopItem> categoryItems;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return widget.loadingData
        ? Center(
            child: Center(
            child: CircularProgressIndicator(),
          ))
        : SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // height: displayHeight(context) * 6,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: widget.categoryItems.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProductItem(
                                  addToCart: () {
                                    setState(() {
                                      widget.cartItems
                                          .add(widget.categoryItems[index]);
                                    });

                                    print("added");
                                  },
                                  // productImage:
                                  //     shopItems[index].imageUrl,
                                  productImage:
                                      widget.categoryItems[index].imageUrl,
                                  price: widget.categoryItems[index].price,
                                  title: widget.categoryItems[index].title,
                                  productVendor:
                                      widget.categoryItems[index].productVendor,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                                value: BlocProvider.of<
                                                    ShopBloc>(context)
                                                  ..add(ItemAddingCartEvent(
                                                      cartItems:
                                                          widget.cartItems)),
                                                child: ProductDetail(
                                                  shopItem: widget
                                                      .categoryItems[index],
                                                ))));
                                  },
                                );
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
