import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants/color_constants.dart';
import '../../utils/utils.dart';

class DeleteScreen extends StatefulWidget {
  final String bakery;
  const DeleteScreen({super.key, required this.bakery});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final auth = FirebaseAuth.instance;
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final nameController = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  Random rand = Random();

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
        title: Text('Delete/Edit Product'),
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
                    return ListTile(
                      title: Text(data['title'].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price: PKR" + data['price']),
                          Text("Rating: " +
                              (rand.nextDouble() * 3 + 2).toStringAsFixed(1))
                        ],
                      ),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(data);
                                },
                              )),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                                onTap: () {
                                  products
                                      .doc(data['id'].toString())
                                      .delete()
                                      .then((value) => print("User Updated"))
                                      .catchError((error) => print(
                                          "Failed to update user: $error"));
                                },
                              ))
                        ],
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
    final _formkey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            height: 310,
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Desc';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    products
                        .doc(data['id'].toString())
                        .update({
                          'title': nameController.text.trim(), // John Doe
                          'price':
                              priceController.text.trim(), // Stokes and Sons
                          'detail': descriptionController.text.trim(),
                        })
                        .then((value) => print("User Updated"))
                        .catchError(
                            (error) => print("Failed to update user: $error"));
                    nameController.clear();
                    priceController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}
