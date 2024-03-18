import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bakeway_app/constants/color_constants/color_constants.dart';

import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

double value = 0;

class _CheckOutState extends State<CheckOut> {
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference products =
      FirebaseFirestore.instance.collection('orders');

  int endTime = DateTime.now().millisecondsSinceEpoch +
      1000 * 60 * 30; // 30 minutes from now
  bool isTimeUp = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(milliseconds: 1000 * 60 * 30), () {
      setState(() {
        isTimeUp = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: products
                    .where('email', isEqualTo: user.email)
                    .orderBy('id', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Stack(children: [
                        Container(
                          height: _height,
                          padding: EdgeInsets.only(top: 100.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/splashscreen.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/bike.png'),
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 300.0),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Your Food Will Be Delivered Promptly By A ',
                                      ),
                                      TextSpan(
                                        text: 'BAKEWAY',
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      TextSpan(text: ' Rider.'),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20.0),
                                Text('Order ID: ' + data['id']),
                                SizedBox(height: 20.0),
                                Text('Delivery Time Remaining'),
                                CountdownTimer(
                                  endTime:
                                      (double.parse(data['id']) + 1000 * 60 * 3)
                                          .toInt(),
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Column(
                                        children: [
                                          Text(
                                            'Delivered Successfully',
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showMyDialog();
                                                  },
                                                  child:
                                                      Text('Rate Your Order'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.purple,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      // if (time.min == null && time.sec == 1) {
                                      //   NotificationService().showNotification(
                                      //       title: 'Order Delivered',
                                      //       body: 'Enjoy!');
                                      // }
                                      if (time.min == null) {
                                        return Text(
                                          '0:${time.sec} remaining',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          '${time.min}:${time.sec} remaining',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.purple,
                                                  radius: 20.0,
                                                  child: Icon(Icons
                                                      .headset_mic_outlined)),
                                            ),
                                            SizedBox(width: 10.0),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Helpline Number',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          '+92-323-2253929',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/main-screen');
                                              },
                                              child: Text('Continue Shopping'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.purple,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  );
                })));
  }

  Future<void> showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Give your Feedback'),
          content: Container(
            height: 70,
            // decoration: BoxDecoration(
            //     color: Colors.black, borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(10),
            child: RatingStars(
              value: value,
              onValueChanged: (v) {
                //
                setState(() {
                  value = v;
                });
                Navigator.pop(context);
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
              valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: const Color(0xffe7e8ea),
              starColor: kDefaultColor,
            ),
          ),
        );
      },
    );
  }
}
