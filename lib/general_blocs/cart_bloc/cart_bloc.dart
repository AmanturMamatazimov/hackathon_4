import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

import '../../utils/utils.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required CartRepository cartRepository,
  })  : _cartRepo = cartRepository,
        super(CartInitialState()) {
    on<CartStarted>(_startCart);
    on<CartAddItem>(_addItem);
    on<CartRemoveItem>(_removeItem);
    on<CartPutItems>(_putItems);
    // on<CartRestart>(_restartCart);
  }
  final CartRepository _cartRepo;
  void _startCart(
    CartStarted event,
    Emitter<CartState> emit,
  ) {
    emit(const CartChangedState(CartModel(id: 1, colors: [], restarted: true)));
  }

  void _addItem(
    CartAddItem event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartChangedState) {
      _cartRepo.addItemToCart(event.item);
      emit(
        CartChangedState(
          CartModel(
              colors: [...state.cart.colors, event.item], restarted: false),
        ),
      );
    }
  }

  void _removeItem(
    CartRemoveItem event,
    Emitter<CartState> emit,
  ) {
    final state = this.state;
    if (state is CartChangedState) {
      _cartRepo.removeItemFromCart(event.item);
      emit(
        CartChangedState(
          CartModel(colors: [...state.cart.colors]..remove(event.item)),
        ),
      );
    }
  }

  void _putItems(
    CartPutItems event,
    Emitter<CartState> emit,
  ) {
    if (state is CartChangedState) {
      // _cartRepo.putItemsToCart(event.items);
      emit(
        const CartChangedState(
          CartModel(id: 2, colors: [], restarted: true),
        ),
      );
    }
  }

  //   void _restartCart(
  //   CartRestart event,
  //   Emitter<CartState> emit,
  // ) {
  //   emit(CartChangedState(CartModel(id: cartId, colors: [])));
  // }

}
