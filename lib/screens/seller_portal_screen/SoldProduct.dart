import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants/color_constants.dart';
import '../../utils/utils.dart';

class SoldScreen extends StatefulWidget {
  final String bakery;
  const SoldScreen({super.key, required this.bakery});

  @override
  State<SoldScreen> createState() => _SoldScreenState();
}

class _SoldScreenState extends State<SoldScreen> {
  final auth = FirebaseAuth.instance;
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final nameController = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('sellerOrder');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        title: Text('Order History'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
                products.where('vendor', isEqualTo: widget.bakery).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data['item']),
                                Text('PKR ${data["amount"]}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Category: ${data["category"]}'),
                                Text('Quantity: ${data["quantity"]}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date: ' +
                                    data["date"].toString().substring(0, 10)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> showMyDialog(Map<String, dynamic> data) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Product Price',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  products
                      .doc(data['id'].toString())
                      .update({
                        'title': nameController.text.trim(), // John Doe
                        'price': priceController.text.trim(), // Stokes and Sons
                        'detail': descriptionController.text.trim(),
                      })
                      .then((value) => print("User Updated"))
                      .catchError(
                          (error) => print("Failed to update user: $error"));
                  nameController.clear();
                  priceController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}
