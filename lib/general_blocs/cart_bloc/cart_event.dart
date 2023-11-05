part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {}

class CartAddItem extends CartEvent {
  final ColorModel item;
  const CartAddItem(this.item);

  @override
  List<Object> get props => [item];
}

class CartRemoveItem extends CartEvent {
  final ColorModel item;
  const CartRemoveItem(this.item);

  @override
  List<Object> get props => [item];
}

class CartPutItems extends CartEvent {
  // final List<Color> items;
  // const CartPutItems(this.items);

  // @override
  // List<Object> get props => [items];
}

// class CartRestart extends CartEvent {}
