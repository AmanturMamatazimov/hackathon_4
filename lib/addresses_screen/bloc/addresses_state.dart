// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addresses_bloc.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object?> get props => [];
}

class AddressesInitialState extends AddressesState {
  const AddressesInitialState();
}

class AddressesLoadingState extends AddressesState {}

class AddressesEmptyState extends AddressesState {}

class AddressesLoadedState extends AddressesState {
  const AddressesLoadedState({
    required this.addresses,
    this.hasReachedMax = false,
    this.makedOrder,
    this.makingOrderError,
    this.isMakingOrder = false,
    this.errorWhileDeleting = '',
    this.deletedAddressid,
  });
  final bool hasReachedMax;
  final int? deletedAddressid;
  final bool isMakingOrder;
  final String errorWhileDeleting;
  final String? makingOrderError;
  final List<OrderModel>? makedOrder;
  final List<AddressesModel> addresses;

  @override
  List<Object?> get props => [
        addresses,
        hasReachedMax,
        makedOrder,
        isMakingOrder,
        makingOrderError,
        errorWhileDeleting,
        deletedAddressid
      ];
  // ПРОВЕРИТЬ РАБОТАЕТ ЛИ ЛИСТЕН ЕСЛИ РЕБИЛД УБРАТЬ КАК НИБУДЬ

  AddressesLoadedState copyWith({
    bool? hasReachedMax,
    List<OrderModel>? makedOrder,
    List<AddressesModel>? addresses,
    bool? isMakingOrder,
    String? makingOrderError,
    int? deletedAddressid,
    String? errorWhileDeleting,
  }) {
    return AddressesLoadedState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isMakingOrder: isMakingOrder ?? this.isMakingOrder,
      makedOrder: makedOrder ?? this.makedOrder,
      makingOrderError: makingOrderError ?? this.makingOrderError,
      errorWhileDeleting: errorWhileDeleting ?? this.errorWhileDeleting,
      addresses: addresses ?? this.addresses,
      deletedAddressid: deletedAddressid ?? this.deletedAddressid,
    );
  }
}

class AddressesGetErrorState extends AddressesState {
  final String errorText;
  const AddressesGetErrorState({required this.errorText});

  @override
  List<Object> get props => [errorText];
}
