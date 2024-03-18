import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/screens/shipping_address_screen/shipping_address.dart';
import 'package:bakeway_app/shared_components/decorated_textfield/decorated_textfield.dart';
import 'package:bakeway_app/shared_components/margin_container/margin_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen(
      {Key? key, required this.id, required this.itemCount})
      : super(key: key);
  final String id;
  final int itemCount;
  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  // final Completer<GoogleMapController> _controller = Completer();
  // List<Marker> _markers = <Marker>[];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14,
  );

  String _currentAddress = '';
  String _currentCity = '';
  Position? _currentPosition;
  bool loading = true;

  bool _switchValue = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('orders');
  final fireStore2 = FirebaseFirestore.instance.collection('sellerOrder');

  Future<void> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print(position);
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}';
        _currentCity = '${place.subAdministrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    if (loading == true) {
      _getCurrentPosition();
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kDefaultColor,
          title: const Text('Live Address'),
          leading: IconButton(
            onPressed: () {
              fireStore.doc(widget.id).delete();
              for (int i = 0; i < widget.itemCount; i++) {
                fireStore2
                    .doc((double.parse(widget.id) + i).toStringAsFixed(0))
                    .delete();
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(alignment: Alignment.center, children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // mapType: MapType.normal,
            // zoomControlsEnabled: true,
            // zoomGesturesEnabled: true,
            // myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            // trafficEnabled: false,
            // rotateGesturesEnabled: true,
            // buildingsEnabled: true,
            // markers: Set<Marker>.of(_markers),
            // onMapCreated: (GoogleMapController controller){
            //   _controller.complete(controller);
            // },
          ),
          Positioned(
            bottom: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressTextScreen(
                              id: widget.id,
                              itemCount: widget.itemCount,
                              currentAddress: _currentAddress,
                              currentCity: _currentCity,
                            )));
              },
              child: Text(
                'continue'.toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDefaultColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ]),

        // SingleChildScrollView(
        //   child: SafeArea(
        //     child: MarginContainer(children: [
        //       GoogleMap(
        //         initialCameraPosition: _kGooglePlex,
        //
        //
        //       ),
        //       Form(
        //         key: _formkey,
        //         child: Column(
        //           children: [
        //             DecoratedTextField(
        //               width: _width,
        //               height: _height,
        //               icon: Center(
        //                 child: Text(
        //                   'Address Label',
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               controller: nameController,
        //               hintText: 'Address Label',
        //               obscureText: false,
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Enter Address Label';
        //                 }
        //                 return null;
        //               },
        //             ),
        //             DecoratedTextField(
        //               width: _width,
        //               height: _height,
        //               icon: Center(
        //                 child: Text(
        //                   'Mobile Number',
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               controller: numberController,
        //               hintText: 'Mobile Number',
        //               obscureText: false,
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Enter Mobile Number';
        //                 }
        //                 return null;
        //               },
        //             ),
        //             DecoratedTextField(
        //               width: _width,
        //               height: _height,
        //               icon: const Center(
        //                 child: Text(
        //                   'State',
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               controller: stateController,
        //               hintText: 'Enter State',
        //               obscureText: false,
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Enter State';
        //                 }
        //                 return null;
        //               },
        //             ),
        //             DecoratedTextField(
        //               width: _width,
        //               height: _height,
        //               icon: const Center(
        //                 child: Text(
        //                   'City',
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               controller: cityController,
        //               hintText: 'Enter City',
        //               obscureText: false,
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Enter City';
        //                 }
        //                 return null;
        //               },
        //             ),
        //             DecoratedTextField(
        //               width: _width,
        //               height: _height,
        //               icon: Center(
        //                 child: Text(
        //                   'Street',
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               controller: streetController,
        //               hintText: 'Street',
        //               obscureText: false,
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Enter Street';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         color: kDefaultColor,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Set as default'),
        //           Switch(
        //             value: _switchValue,
        //             onChanged: (bool val) {
        //               setState(() {
        //                 _switchValue = val;
        //               });
        //             },
        //           )
        //         ],
        //       ),
        //       Divider(
        //         color: kDefaultColor,
        //       ),
        //       SizedBox(
        //         height: 33,
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           if (_formkey.currentState!.validate()) {
        //             Navigator.pushNamed(context, '/order-placed');
        //           }
        //         },
        //         child: Text('Place Order'),
        //         style: ButtonStyle(
        //           backgroundColor: MaterialStateProperty.all(kDefaultColor),
        //           elevation: MaterialStateProperty.all(7),
        //           fixedSize: MaterialStateProperty.all(
        //             Size(_width * 0.7, _height * 0.077),
        //           ),
        //         ),
        //       ),
        //     ], columnAlignment: CrossAxisAlignment.center),
        //   ),
        // ),
      );
    }
  }
}
