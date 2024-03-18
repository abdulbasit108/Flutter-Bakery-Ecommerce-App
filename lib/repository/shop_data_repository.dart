import 'package:bakeway_app/model/shop.dart';

class ShopDataProvider {
  Future<ShopData> getShopItems() async {
    List<ShopItem> shopItems = [
      ShopItem(
        imageUrl:
            "https://www.mybakingaddiction.com/wp-content/uploads/2011/10/lr-0953-720x540.jpg",
        price: 22,
        quantity: 1,
        weight: 2,
        title: 'Shoes',
        productVendor: 'Bata',
        category: 'Cakes',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx-g2GSISpufBWs1ZLWkd_T3KvXCU_TTerPw&usqp=CAU",
        price: 50,
        quantity: 1,
        weight: 2,
        title: 'Headpone',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        category: 'Bread',
        productVendor: 'Audionic',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFhnA96BAkDXRTx8hfJZVXT18hMBCJ8zVmQw&usqp=CAU",
        price: 80,
        quantity: 1,
        weight: 3,
        title: 'Sharee',
        productVendor: 'Laam',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        category: 'Biscuit',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDEjZY6mmImADpDqFtmxrksJttjRCSax9Iwg&usqp=CAU",
        price: 30,
        quantity: 1,
        weight: 3,
        title: 'Bat',
        productVendor: 'Laam',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        category: 'Cakes',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLziqzVEjoRBTCp49fyPx_BiXwfFmv-Rpw0w&usqp=CAU",
        price: 40,
        quantity: 1,
        weight: 2,
        title: 'Jwellery',
        productVendor: 'ARY Jewellers',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        category: 'Rusks',
      ),
    ];
    return ShopData(shopitems: shopItems);
  }

  Future<ShopData> geCartItems() async {
    List<ShopItem> shopItems = [
      ShopItem(
        imageUrl:
            "https://www.mybakingaddiction.com/wp-content/uploads/2011/10/lr-0953-720x540.jpg",
        price: 22,
        quantity: 1,
        weight: 2,
        title: 'Shoes',
        productVendor: 'Bata',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        category: 'Cakes',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx-g2GSISpufBWs1ZLWkd_T3KvXCU_TTerPw&usqp=CAU",
        price: 50,
        quantity: 1,
        weight: 1,
        title: 'Headpone',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        productVendor: 'Audionic',
        category: 'Bread',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFhnA96BAkDXRTx8hfJZVXT18hMBCJ8zVmQw&usqp=CAU",
        price: 80,
        quantity: 1,
        weight: 3,
        title: 'Sharee',
        category: 'Biscuit',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        productVendor: 'Laam',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDEjZY6mmImADpDqFtmxrksJttjRCSax9Iwg&usqp=CAU",
        price: 30,
        quantity: 1,
        weight: 2,
        category: 'Cakes',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        title: 'Bat',
        productVendor: 'CA',
      ),
      ShopItem(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLziqzVEjoRBTCp49fyPx_BiXwfFmv-Rpw0w&usqp=CAU",
        price: 40,
        quantity: 1,
        weight: 3,
        category: 'Rusks',
        detail:
            'a sweet baked food made from a dough or thick batter usually containing flour and sugar and often shortening, eggs, and a raising agent',
        title: 'Jwellery',
        productVendor: 'ARY Jewellers',
      ),
    ];
    return ShopData(shopitems: shopItems);
  }
}
