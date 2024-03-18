import 'package:bakeway_app/constants/color_constants/color_constants.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Bloc/CartBloc/cart_bloc.dart';
import '../../model/customer.dart';

import '../../shared_components/section_heading/section_heading.dart';

import '../product_detail_screen/product_detail_screen_old.dart';

import '../product_detail_screen/product_page.dart';
import 'components/category_button/category_button.dart';
import 'components/product_card/product_card.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<Customer> getUserData() async {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('customer');
  QuerySnapshot querySnapshot =
      await usersCollection.where('email', isEqualTo: user.email).get();
  Customer customerData = Customer(email: '', id: '', imageUrl: '', name: '');
  if (querySnapshot.docs.isNotEmpty) {
    Customer data = Customer.fromFirestore(querySnapshot.docs[0]);
    customerData = data;
  }
  return customerData;
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Customer> _futureCustomerData;
  final _advancedDrawerController = AdvancedDrawerController();
  bool loadingData = true;
  final auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  @override
  void initState() {
    super.initState();
    _futureCustomerData = getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // getItems();
    // shopItems = shopData.shopitems;
    void _handleMenuButtonPressed() {
      // NOTICE: Manage Advanced Drawer state through the Controller.
      // _advancedDrawerController.value = AdvancedDrawerValue.visible();
      _advancedDrawerController.showDrawer();
    }

    return Scaffold(
        body: FutureBuilder<Customer>(
            future: _futureCustomerData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred while loading data.'),
                );
              } else {
                final customerData = snapshot.data!;

                return AdvancedDrawer(
                  backdropColor: kDefaultContrastColor,
                  controller: _advancedDrawerController,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  animateChildDecoration: true,
                  rtlOpening: false,
                  // openScale: 1.0,
                  disabledGestures: false,
                  childDecoration: const BoxDecoration(
                    // NOTICE: Uncomment if you want to add shadow behind the page.
                    // Keep in mind that it may cause animation jerks.
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 0.0,
                    //   ),
                    // ],
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: kDefaultColor,
                      leading: IconButton(
                        onPressed: _handleMenuButtonPressed,
                        icon: ValueListenableBuilder<AdvancedDrawerValue>(
                          valueListenable: _advancedDrawerController,
                          builder: (_, value, __) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Icon(
                                value.visible ? Icons.clear : Icons.menu,
                                key: ValueKey<bool>(value.visible),
                              ),
                            );
                          },
                        ),
                      ),
                      elevation: 0,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('HOME'),
                          SizedBox(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/order-complete');
                                    },
                                    child: const IgnorePointer(
                                      child: Icon(
                                        Icons.delivery_dining,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 5, vertical: 1),
                                  //   // color: Colors.white,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius:
                                  //           BorderRadius.circular(300)),
                                  //   child: Text(
                                  //     '0',
                                  //     style: TextStyle(
                                  //         fontSize: 12, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          // Text(
                          //   'Bakeway',
                          //   style: TextStyle(color: Colors.red),
                          // ),
                        ],
                      ),
                      // actions: [Icon(ba)],
                    ),
                    body: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 2000),
                                autoPlay: true,
                              ),
                              items: [
                                'assets/images/Banner.jpg',
                                'assets/images/Banner2.jpg'
                              ]
                                  .map(
                                    (item) => Center(
                                      child:
                                          Image.asset(item, fit: BoxFit.cover),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (BuildContext
                                                              context) =>
                                                          ShopBloc(),
                                                      child: const ProductPage(
                                                          category: 'Biscuit'),
                                                    )));
                                      },
                                      child: CategoryButton(
                                        width: _width,
                                        height: _height,
                                        icon: FontAwesomeIcons.cookieBite,
                                        buttonColor: kDefaultColor,
                                        buttonText: 'Biscuit',
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (BuildContext
                                                              context) =>
                                                          ShopBloc(),
                                                      child: const ProductPage(
                                                          category: 'Cakes'),
                                                    )));
                                      },
                                      child: CategoryButton(
                                        width: _width,
                                        height: _height,
                                        icon: FontAwesomeIcons.cakeCandles,
                                        buttonColor: kDefaultContrastColor,
                                        buttonText: 'Cakes',
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (BuildContext
                                                              context) =>
                                                          ShopBloc(),
                                                      child: const ProductPage(
                                                          category: 'Bread'),
                                                    )));
                                      },
                                      child: CategoryButton(
                                        width: _width,
                                        height: _height,
                                        icon: FontAwesomeIcons.breadSlice,
                                        buttonColor: kDefaultColor,
                                        buttonText: 'Bread',
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (BuildContext
                                                                context) =>
                                                            ShopBloc(),
                                                        child:
                                                            const ProductPage(
                                                                category:
                                                                    'Rusks'),
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 32),
                                                decoration: BoxDecoration(
                                                  color: kDefaultContrastColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                width: _width * 0.15,
                                                height: _height * 0.066,
                                                child: const ImageIcon(
                                                  AssetImage(
                                                      'assets/images/rusk.png'),
                                                  color: Colors.white,
                                                )),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              width: _width * 0.16,
                                              child: const Text(
                                                'RUSKS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (BuildContext
                                                                context) =>
                                                            ShopBloc(),
                                                        child:
                                                            const ProductPage(
                                                                category:
                                                                    'Donuts'),
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 32),
                                                decoration: BoxDecoration(
                                                  color: kDefaultColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                width: _width * 0.15,
                                                height: _height * 0.066,
                                                child: const ImageIcon(
                                                  AssetImage(
                                                      'assets/images/Donuts.png'),
                                                  color: Colors.white,
                                                )),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              width: _width * 0.16,
                                              child: const Text(
                                                'DONUTS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (BuildContext
                                                                context) =>
                                                            ShopBloc(),
                                                        child:
                                                            const ProductPage(
                                                                category:
                                                                    'Snacks'),
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 32),
                                                decoration: BoxDecoration(
                                                  color: kDefaultContrastColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                width: _width * 0.15,
                                                height: _height * 0.066,
                                                child: const ImageIcon(
                                                  AssetImage(
                                                      'assets/images/snack.png'),
                                                  color: Colors.white,
                                                )),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              width: _width * 0.16,
                                              child: const Text(
                                                'SNACKS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (BuildContext
                                                                context) =>
                                                            ShopBloc(),
                                                        child:
                                                            const ProductPage(
                                                                category:
                                                                    'Sweets'),
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 32),
                                                decoration: BoxDecoration(
                                                  color: kDefaultColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                width: _width * 0.15,
                                                height: _height * 0.066,
                                                child: const ImageIcon(
                                                  AssetImage(
                                                      'assets/images/Sweets.png'),
                                                  color: Colors.white,
                                                )),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              width: _width * 0.16,
                                              child: const Text(
                                                'SWEETS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: const SectionHeading(
                                title: 'Popular Items',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Chocolate Cake',
                                          productDesc:
                                              'Delight your taste buds with our decadent cakes! Made with the finest ingredients and baked to perfection, our cakes are a treat for any occasion. From classic flavors like vanilla and chocolate to unique options like red velvet and tiramisu, we have something for every palate. Order now and enjoy a slice of heaven delivered straight to your door.',
                                          productPrice: '1200',
                                          productVendor: 'Kababjees',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Cakes'),
                                                        )));
                                          },
                                          imageUrl:
                                              'https://images.pexels.com/photos/132694/pexels-photo-132694.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      'https://images.pexels.com/photos/132694/pexels-photo-132694.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                  productName: 'Chocolate Cake',
                                  productVendor: 'Kababjees',
                                  productPrice: 'PKR 1200',
                                ),
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Chocolate Sprinkle',
                                          productDesc:
                                              "Indulge in the sweet, fluffy goodness of our freshly baked donut. Made from the finest ingredients, this classic treat is handcrafted with love and care to ensure that every bite is a delight. Whether you're a fan of glazed, chocolate, or sprinkles, we've got you covered with a wide range of toppings to choose from. Perfect for breakfast, brunch, or a midday snack, our donuts are the perfect way to satisfy your sweet tooth and brighten your day.",
                                          productPrice: '180',
                                          productVendor: 'Dunkin',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Donuts'),
                                                        )));
                                          },
                                          imageUrl:
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIQq070WcDheYk9ei_L9-_5ePTBM3zbZFIQi-dojsNn0VxHSeVTVz6BxbWAih_gBKqc3k&usqp=CAU',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIQq070WcDheYk9ei_L9-_5ePTBM3zbZFIQi-dojsNn0VxHSeVTVz6BxbWAih_gBKqc3k&usqp=CAU',
                                  productName: 'Chocolate Sprinkle',
                                  productVendor: 'Dunkin',
                                  productPrice: 'PKR 180',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Chocolate Cake',
                                          productDesc:
                                              'Chocolate Chip Biscuits - Delicious, melt-in-your-mouth biscuits with chunks of rich chocolate in every bite. Perfect for satisfying your sweet tooth cravings.',
                                          productPrice: '120',
                                          productVendor: 'Pie in the Sky',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Biscuit'),
                                                        )));
                                          },
                                          imageUrl:
                                              "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/easy_choc_biscuits-f98c5dd.jpg?quality=90&resize=960,872",
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/easy_choc_biscuits-f98c5dd.jpg?quality=90&resize=960,872",
                                  productName: 'Choco Chip Cookie',
                                  productVendor: 'Pie in the Sky',
                                  productPrice: 'PKR 120',
                                ),
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                            productName: 'Veggie Samosa',
                                            productDesc:
                                                "Our Spicy Vegetable Samosas are a delicious and satisfying snack, perfect for any occasion. Made with a crispy, flaky pastry and filled with a flavorful mixture of potatoes, peas, onions, and aromatic spices, these samosas pack a punch of flavor and heat. Served with a side of tangy chutney, they're the perfect way to spice up your day. Whether you're looking for a quick and easy snack or a tasty addition to your meal, our Spicy Vegetable Samosas are the perfect choice.",
                                            productPrice: '50',
                                            productVendor: 'United King',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (BuildContext
                                                                    context) =>
                                                                ShopBloc(),
                                                            child:
                                                                const ProductPage(
                                                                    category:
                                                                        'Snacks'),
                                                          )));
                                            },
                                            imageUrl:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCsvrSQCHCOB1M_1GKK3PQmXfohQmoxf-IVPJI4bft_FHMnaobNI3nqP0ZVLwTpM3EIoA&usqp=CAU"),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCsvrSQCHCOB1M_1GKK3PQmXfohQmoxf-IVPJI4bft_FHMnaobNI3nqP0ZVLwTpM3EIoA&usqp=CAU",
                                  productName: 'Veggie Samosa',
                                  productVendor: 'United King',
                                  productPrice: 'PKR 50',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Bread Rusk',
                                          productDesc:
                                              "Our Classic Rusk Biscuits are the perfect companion for your morning tea or coffee. Made with the finest ingredients and baked to perfection, these crunchy biscuits have a satisfying texture and a subtle sweetness that's just right. Dip them in your favorite hot beverage or enjoy them on their own as a quick and easy snack. Whether you're looking for a morning pick-me-up or a delicious snack, our Classic Rusk Biscuits are the perfect choice.",
                                          productPrice: '300',
                                          productVendor: 'Ruskers',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Rusks'),
                                                        )));
                                          },
                                          imageUrl:
                                              "https://floursandfrostings.com/wp-content/uploads/2018/04/IMG_20180412_172512_082-768x768.jpg",
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      "https://floursandfrostings.com/wp-content/uploads/2018/04/IMG_20180412_172512_082-768x768.jpg",
                                  productName: 'Bread Rusk',
                                  productVendor: 'Ruskers',
                                  productPrice: 'PKR 300',
                                ),
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Mix Mithai Box',
                                          productDesc:
                                              "Our Assorted Sweets Gift Box includes a carefully curated selection of chocolates, gummies, and hard candies. Perfect as a sweet treat for yourself or as a gift for someone special.",
                                          productPrice: '1360',
                                          productVendor: 'Asr-e-Sheeran',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Sweets'),
                                                        )));
                                          },
                                          imageUrl:
                                              'https://images.deliveryhero.io/image/fd-pk/LH/moz6-hero.jpg',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      'https://images.deliveryhero.io/image/fd-pk/LH/moz6-hero.jpg',
                                  productName: 'Mix Mithai Box',
                                  productVendor: 'Asr-e-Sheeran',
                                  productPrice: 'PKR 1360',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 8)),
                                ProductCard(
                                  width: _width,
                                  height: _height,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          productName: 'Milk Bread',
                                          productDesc:
                                              "Savor the rich, satisfying flavor and hearty texture of our freshly baked artisan bread. Handcrafted with care and attention to detail, this bread is made using only the finest ingredients and traditional baking techniques. With a crusty exterior and soft, chewy interior, this bread is perfect for toasting, sandwiches, or simply enjoying on its own. Whether you're a fan of sourdough, whole wheat, or seeded bread, our artisan bread is the perfect choice for any occasion.",
                                          productPrice: '110',
                                          productVendor: 'Dawn',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                          create: (BuildContext
                                                                  context) =>
                                                              ShopBloc(),
                                                          child:
                                                              const ProductPage(
                                                                  category:
                                                                      'Bread'),
                                                        )));
                                          },
                                          imageUrl:
                                              'https://assets.bonappetit.com/photos/5c62e4a3e81bbf522a9579ce/16:9/w_4000,h_2250,c_limit/milk-bread.jpg',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      'https://assets.bonappetit.com/photos/5c62e4a3e81bbf522a9579ce/16:9/w_4000,h_2250,c_limit/milk-bread.jpg',
                                  productName: 'Milk Bread',
                                  productVendor: 'Dawn',
                                  productPrice: 'PKR 110',
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  drawer: SafeArea(
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    '/seller-signin'); // Add your button's onTap logic here
                              },
                              child: Container(
                                width: 170,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'SELLER MODE',
                                    style: TextStyle(
                                      color: kDefaultColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ListTileTheme(
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  height: 40,
                                  margin: const EdgeInsets.only(top: 12),
                                  decoration: const BoxDecoration(
                                    color: kDefaultColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/main-screen');
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.arrow_back_ios_new_sharp,
                                          color: kDefaultColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 84.0,
                                        height: 84.0,
                                        margin: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0, left: 16
                                            //right: 120.0,
                                            ),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          color: Colors.black26,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          customerData.imageUrl,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                customerData.name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              customerData.email,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/main-screen');
                                  },
                                  leading: const Icon(Icons.home),
                                  title: const Text('Home'),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/order-history');
                                  },
                                  leading: const Icon(Icons.history),
                                  title: const Text('Order History'),
                                ),
                                ListTile(
                                  onTap: () {
                                    auth.signOut().then((value) {
                                      Navigator.pushNamed(
                                          context, '/signin-screen');
                                    }).onError((error, stackTrace) {
                                      Utils().toastMessage(error.toString());
                                    });
                                  },
                                  leading: const Icon(Icons.logout),
                                  title: const Text('Logout'),
                                ),
                                const Spacer(),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: const Center(
                                      child: Text(
                                          'Terms of Service | Privacy Policy'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
