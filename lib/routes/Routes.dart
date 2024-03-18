import 'package:bakeway_app/screens/order_summary_screen/order_history.dart';
import 'package:bakeway_app/screens/order_summary_screen/order_placed_screen.dart';
import 'package:bakeway_app/screens/order_summary_screen/recent_order.dart';

import 'package:bakeway_app/screens/seller_portal_screen/seller_sign_up_screen.dart';
import 'package:bakeway_app/screens/seller_portal_screen/seller_signin_screen.dart';
import 'package:bakeway_app/screens/shipping_address_screen/shipping_address_maps.dart';
import 'package:bakeway_app/screens/signin_screen/signin_screen.dart';
import 'package:bakeway_app/screens/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/CartBloc/cart_bloc.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/order_summary_screen/cart_screen.dart';
import '../screens/profile_screen/profile_screen.dart';
import '../screens/seller_portal_screen/SellerPortal.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case "/order-summary":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (BuildContext context) => ShopBloc(),
            child: const CartScreen(),
          ),
        );

      case "/profile-screen":
        return MaterialPageRoute(builder: (context) => ProfileScreen());

      case "/main-screen":
        return MaterialPageRoute(builder: (context) => MainScreen());
      case "/seller-screen":
        return MaterialPageRoute(builder: (context) => SellerPortal());
      case "/seller-signin":
        return MaterialPageRoute(builder: (context) => SellerSignInScreen());
      case "/seller-signup":
        return MaterialPageRoute(builder: (context) => SellerSignUpScreen());
      case "/order-placed":
        return MaterialPageRoute(builder: (context) => CheckOut());
      case "/order-history":
        return MaterialPageRoute(builder: (context) => OrderHistory());
      case "/order-recent":
        return MaterialPageRoute(builder: (context) => RecentOrder());
      case "/order-complete":
        return MaterialPageRoute(builder: (context) => CheckOut());
      case "/signin-screen":
        return MaterialPageRoute(builder: (context) => SignInScreen());
    }
  }
}
