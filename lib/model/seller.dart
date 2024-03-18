import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  String email;
  String bakery;
  String cnic;
  String ntn;

  Seller({
    required this.email,
    required this.bakery,
    required this.cnic,
    required this.ntn,
  });

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Seller(
      email: data['email'],
      bakery: data['bakery'],
      cnic: data['cnic'],
      ntn: data['ntn'],
    );
  }
}
