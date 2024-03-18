import 'package:cloud_firestore/cloud_firestore.dart';

class Bakery {
  String email;
  String id;
  String ntn;
  String bakery;
  String cnic;

  Bakery(
      {required this.email,
      required this.id,
      required this.ntn,
      required this.cnic,
      required this.bakery});

  factory Bakery.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Bakery(
        email: data['email'],
        id: data['id'],
        cnic: data['cnic'],
        ntn: data['ntn'],
        bakery: data['bakery']);
  }
}
