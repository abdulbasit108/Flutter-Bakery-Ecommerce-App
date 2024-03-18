import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/screens/shipping_address_screen/shipping_address_maps.dart';
import 'package:bakeway_app/shared_components/decorated_textfield/decorated_textfield.dart';
import 'package:bakeway_app/shared_components/margin_container/margin_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressTextScreen extends StatefulWidget {
  const AddressTextScreen(
      {Key? key,
      required this.id,
      required this.itemCount,
      required this.currentAddress,
      required this.currentCity})
      : super(key: key);
  final String id;
  final int itemCount;
  final String currentAddress;
  final String currentCity;

  @override
  State<AddressTextScreen> createState() => _AddressTextScreenState();
}

class _AddressTextScreenState extends State<AddressTextScreen> {
  bool _switchValue = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('orders');
  final fireStore2 = FirebaseFirestore.instance.collection('sellerOrder');

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    streetController.text = widget.currentAddress;
    cityController.text = widget.currentCity;
    // bool state = false;
    //bool _switchValue = true;
    //final ValueChanged<bool>? onChanged;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        title: const Text('Add Address'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: MarginContainer(children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  DecoratedTextField(
                    width: _width,
                    height: _height,
                    icon: Center(
                      child: Text(
                        'Address Label',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller: nameController,
                    hintText: 'Address Label',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Address Label';
                      }
                      return null;
                    },
                  ),
                  DecoratedTextField(
                    width: _width,
                    height: _height,
                    icon: Center(
                      child: Text(
                        'Mobile Number',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller: numberController,
                    hintText: 'Mobile Number',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Mobile Number';
                      }
                      return null;
                    },
                  ),
                  DecoratedTextField(
                    width: _width,
                    height: _height,
                    icon: const Center(
                      child: Text(
                        'Receiver Name',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller: stateController,
                    hintText: 'Receiver Name',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Receiver Name';
                      }
                      return null;
                    },
                  ),
                  DecoratedTextField(
                    width: _width,
                    height: _height,
                    icon: const Center(
                      child: Text(
                        'City',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller: cityController,
                    hintText: 'Enter City',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter City';
                      }
                      return null;
                    },
                  ),
                  DecoratedTextField(
                    width: _width,
                    height: _height,
                    icon: Center(
                      child: Text(
                        'Address',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    controller: streetController,
                    hintText: 'Address',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: kDefaultColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Set as default'),
                Switch(
                  value: _switchValue,
                  onChanged: (bool val) {
                    setState(() {
                      _switchValue = val;
                    });
                  },
                )
              ],
            ),
            Divider(
              color: kDefaultColor,
            ),
            SizedBox(
              height: 33,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  // Navigator.pushNamed(context, '/order-placed');
                  Navigator.pushNamed(context, '/order-complete');
                }
              },
              child: Text('Confirm Order'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kDefaultColor),
                elevation: MaterialStateProperty.all(7),
                fixedSize: MaterialStateProperty.all(
                  Size(_width * 0.7, _height * 0.077),
                ),
              ),
            ),
          ], columnAlignment: CrossAxisAlignment.center),
        ),
      ),
    );
  }
}
