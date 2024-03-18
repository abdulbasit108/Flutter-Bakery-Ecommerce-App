part of 'cart_bloc.dart';


abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopPageLoadedState extends ShopState {
  ShopData shopData;
  ShopData cartData;

  ShopPageLoadedState({ required this.cartData, required this.shopData});
}


class ItemAddingCartState extends ShopState {
  ShopData cartData;
  List<ShopItem> cartItems;

  ItemAddingCartState({required this.cartData, required this.cartItems});
}


class ItemAddedCartState extends ShopState {
  List<ShopItem> cartItems;

  ItemAddedCartState({required this.cartItems});
}


class ItemDeletingCartState extends ShopState {
  List<ShopItem> cartItems;

  ItemDeletingCartState({required this.cartItems});
}