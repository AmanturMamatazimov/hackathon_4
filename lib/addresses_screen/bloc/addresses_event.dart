part of 'addresses_bloc.dart';

abstract class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

class AddressesLoadEvent extends AddressesEvent {
  const AddressesLoadEvent(
      {this.addresses = const [],
      this.isRefresh = false,
      this.hasReachedMax = false,
      this.isLoadMore = false});
  final List<AddressesModel> addresses;
  final bool isRefresh;
  final bool isLoadMore;
  final bool hasReachedMax;
  @override
  List<Object> get props => [addresses, isRefresh, isLoadMore, hasReachedMax];
}

class MakeOrderEvent extends AddressesEvent {
  const MakeOrderEvent(this.colors);
  final List<ColorModel> colors;
  @override
  List<Object> get props => [colors];
}

class AddressesRestartEvent extends AddressesEvent {}

class AddressesNewAddress extends AddressesEvent {
  const AddressesNewAddress(this.address);
  final AddressesModel address;

  @override
  List<Object> get props => [address];
}

class AddressesDeleteEvent extends AddressesEvent {
  const AddressesDeleteEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

// class AddressSelectedEvent extends AddressesEvent {
//   const AddressSelectedEvent(this.address);
//   final AddressesModel address;
// }
