import 'dart:io';
import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../utils/utils.dart';
import '../widget/round_button.dart';

class AddProduct extends StatefulWidget {
  final String bakery;
  const AddProduct({super.key, required this.bakery});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;
  final _formkey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String dropdownValue = 'Cakes';
  bool loading = false;
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  final String quantity = '1';
  final fireStore = FirebaseFirestore.instance.collection('products');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                    ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kDefaultColor),
                ),
                onPressed: getImage,
                child: Text('Insert Image'),
              ),
              const SizedBox(height: 20.0),
              Form(
                key: _formkey,
                child: Column(
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
                          return 'Enter Description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              DropdownButton<String>(
                value: dropdownValue,
                //  hint: Text('Select Category', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),

                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Cakes',
                  'Donuts',
                  'Biscuit',
                  'Bread',
                  'Rusks',
                  'Snacks',
                  'Sweets'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              RoundButton(
                  title: 'Add',
                  loading: loading,
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/products/' +
                              DateTime.now().millisecondsSinceEpoch.toString());
                      firebase_storage.UploadTask uploadTask =
                          ref.putFile(_image!.absolute);

                      Future.value(uploadTask).then((value) async {
                        var newUrl = await ref.getDownloadURL();
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        fireStore.doc(id).set({
                          'title': nameController.text.trim(), // John Doe
                          'price':
                              priceController.text.trim(), // Stokes and Sons
                          'detail': descriptionController.text.trim(),
                          'category': dropdownValue,
                          'vendor': widget.bakery,
                          'imageUrl': newUrl,
                          'id': id
                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('uploaded');
                        }).onError((error, stackTrace) {
                          print(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                      Navigator.pushNamed(context, '/seller-screen');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
