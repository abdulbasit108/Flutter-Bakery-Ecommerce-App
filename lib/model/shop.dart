import 'package:cloud_firestore/cloud_firestore.dart';

class ShopData {
  List<ShopItem> shopitems;

  ShopData({required this.shopitems});

  void addProduct(ShopItem p) {
    shopitems.add(p);
  }

  void removeProduct(ShopItem p) {
    shopitems.add(p);
  }
}

class ShopItem {
  String imageUrl;
  String title;
  String detail;
  String productVendor;
  int price;
  int weight;
  String category;
  int quantity;

  ShopItem(
      {required this.imageUrl,
      required this.price,
      required this.detail,
      required this.category,
      required this.weight,
      required this.quantity,
      required this.title,
      required this.productVendor});

  factory ShopItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ShopItem(
      imageUrl: data['imageUrl'],
      title: data['title'],
      detail: data['detail'],
      productVendor: data['vendor'],
      price: int.parse(data['price']),
      weight: 1,
      category: data['category'],
      quantity: 1,
    );
  }
}
