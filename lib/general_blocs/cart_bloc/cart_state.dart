part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartChangedState extends CartState {
  const CartChangedState(this.cart);
  final CartModel cart;
  @override
  List<Object?> get props => [cart.colors, cart.restarted, cart.id];
}
