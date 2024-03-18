import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bakeway_app/model/shop.dart';
import 'package:bakeway_app/repository/shop_data_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopDataProvider shopDataProvider = ShopDataProvider();
  ShopBloc() : super(ShopInitial()) {
    add(ShopPageInitializedEvent());
  }
//
  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is ShopPageInitializedEvent) {
      ShopData shopData = await shopDataProvider.getShopItems();
      ShopData cartData = await shopDataProvider.geCartItems();
      yield ShopPageLoadedState(shopData: shopData, cartData: cartData);
    }
    if (event is ItemAddingCartEvent) {
      ShopData cartData = await shopDataProvider.geCartItems();
      yield ItemAddingCartState(cartItems: event.cartItems, cartData: cartData);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if (event is ItemDeleteCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }
  }
}
