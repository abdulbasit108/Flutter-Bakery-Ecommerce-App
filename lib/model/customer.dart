import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String email;
  String id;
  String imageUrl;
  String name;

  Customer({
    required this.email,
    required this.id,
    required this.imageUrl,
    required this.name,
  });

  factory Customer.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Customer(
      email: data['email'],
      id: data['id'],
      imageUrl: data['imageUrl'],
      name: data['name'],
    );
  }
}
