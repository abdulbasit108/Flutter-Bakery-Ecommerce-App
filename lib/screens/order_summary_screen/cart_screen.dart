import 'package:bakeway_app/screens/shipping_address_screen/shipping_address.dart';
import 'package:bakeway_app/screens/shipping_address_screen/shipping_address_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bakeway_app/model/shop.dart';
import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/shared_components/section_heading/section_heading.dart';

import '../../Bloc/CartBloc/cart_bloc.dart';

import '../../utils/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ShopItem> cartItems = [];
  double totalAmount = 0;
  double delivery = 125;
  final fireStore = FirebaseFirestore.instance.collection('orders');
  final fireStore2 = FirebaseFirestore.instance.collection('sellerOrder');
  final user = FirebaseAuth.instance.currentUser!;
  String items = '';

  void calculateTotalAmount(List<ShopItem> list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ShopPageLoadedState) {
          //cartItems = state.cartData.shopitems;
          //calculateTotalAmount(cartItems);
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }

        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 90,
                height: 40,
                margin: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
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
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: kDefaultColor,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Text(
                  'Order summary',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                child: cartItems == null || cartItems.length == 0
                    ? const Center(child: Text('Your Cart is Empty'))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              width: _width * 0.9,
                              height: 130,
                              decoration: BoxDecoration(
                                color: kDefaultColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(52),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Image.network(
                                        //   cartItems[index].imageUrl,
                                        //   height: 64,
                                        //   width: 64,
                                        // ),
                                        //SizedBox(width: 20),
                                        //SectionHeading(title: 'Crunch Cake'),
                                        SectionHeading(
                                            title: cartItems[index].title),

                                        const Text(
                                          'PKR',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Baked By ${cartItems[index].productVendor}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${cartItems[index].price * cartItems[index].quantity}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //alignment: Alignment.center,

                                          width: 30,
                                          height: 30,
                                          margin: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: kDefaultColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 1.1,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            //alignment: Alignment.center,
                                            icon: const Icon(Icons.cancel),
                                            //EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),

                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                if (state
                                                    is ShopPageLoadedState) {
                                                  state.cartData.shopitems
                                                      .removeAt(index);
                                                  calculateTotalAmount(
                                                      cartItems);
                                                  BlocProvider.of<ShopBloc>(
                                                      context)
                                                    ..add(ItemDeleteCartEvent(
                                                        cartItems: state
                                                            .cartData.shopitems,
                                                        index: 1));
                                                } else if (state
                                                    is ItemAddedCartState) {
                                                  state.cartItems
                                                      .removeAt(index);
                                                  calculateTotalAmount(
                                                      cartItems);

                                                  BlocProvider.of<ShopBloc>(
                                                      context)
                                                    ..add(ItemDeleteCartEvent(
                                                        cartItems:
                                                            state.cartItems,
                                                        index: 1));
                                                } else if (state
                                                    is ItemDeletingCartState) {
                                                  state.cartItems
                                                      .removeAt(index);
                                                  calculateTotalAmount(
                                                      cartItems);

                                                  BlocProvider.of<ShopBloc>(
                                                      context)
                                                    ..add(ItemDeleteCartEvent(
                                                        cartItems:
                                                            state.cartItems,
                                                        index: 1));
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          margin: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: kDefaultColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 1.1,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(Icons.remove),
                                            color: Colors.white,
                                            onPressed: () {
                                              if (cartItems[index].quantity > 0)
                                                setState(() {
                                                  calculateTotalAmount(
                                                      cartItems);
                                                  cartItems[index].quantity--;
                                                });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 30,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              cartItems[index]
                                                  .quantity
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 22),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          margin: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: kDefaultColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 1.1,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(Icons.add),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                calculateTotalAmount(cartItems);
                                                cartItems[index].quantity++;
                                              });
                                            },
                                          ),
                                        ),
                                        //Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Align(
                //alignment: Alignment.bottomCenter,
                child: Container(
                  width: _width * 0.95,
                  height: _height * 0.30,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: kDefaultColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(52)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'PKR ${totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tax Fee (13%)',
                            style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'PKR ${(totalAmount * 0.13).toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delivery Fee',
                            style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'PKR ${delivery.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'PKR ${(totalAmount + 125 + double.parse((totalAmount * 0.13).toStringAsFixed(2))).toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -32),
                child: InkWell(
                  onTap: () {
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    for (int i = 0; i < cartItems.length; i++) {
                      items = items + cartItems[i].title + ' , ';
                      fireStore2
                          .doc((double.parse(id) + i).toStringAsFixed(0))
                          .set({
                        'id': (double.parse(id) + i).toStringAsFixed(0),
                        'date': DateTime.now().toString(),
                        'email': user.email,
                        'item': cartItems[i].title,
                        'category': cartItems[i].category,
                        'quantity': cartItems[i].quantity,
                        'vendor': cartItems[i].productVendor,
                        'amount': (cartItems[i].price * cartItems[i].quantity)
                            .toStringAsFixed(0),
                      });
                    }

                    fireStore.doc(id).set({
                      'id': id,
                      'date': DateTime.now().toString(),
                      'email': user.email,
                      'items': items,
                      'amount': (totalAmount +
                              125 +
                              double.parse(
                                  (totalAmount * 0.13).toStringAsFixed(2)))
                          .toStringAsFixed(0),
                    });
                    items = '';
                    NotificationService().scheduleNotification(
                        title: 'Order Delivered!',
                        body: 'Order ID: ' + id,
                        scheduledNotificationDateTime:
                            (DateTime.now()).add(const Duration(minutes: 3)));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShippingAddressScreen(
                                  id: id,
                                  itemCount: cartItems.length,
                                )));
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
                          'Checkout'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
