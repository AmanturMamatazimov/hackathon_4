part of 'address_add_edit_bloc.dart';

abstract class AddressAddEditState extends Equatable {
  const AddressAddEditState();

  @override
  List<Object?> get props => [];
}

class AddressAddEditInitial extends AddressAddEditState {
  const AddressAddEditInitial();
}

class AddressAddEditLoadingState extends AddressAddEditState {
  const AddressAddEditLoadingState();
}

class AddressAddEditSuccessState extends AddressAddEditState {
  const AddressAddEditSuccessState(this.address);
  final AddressesModel address;

  @override
  List<Object?> get props => [address];
}

class AddressAddEditErrorState extends AddressAddEditState {
  const AddressAddEditErrorState(this.text);
  final String text;
  @override
  List<Object?> get props => [text];
}

class AddressAddEditLoadedState extends AddressAddEditState {
  final String country;
  final String city;
  final String fullAddress;
  final bool? isDefault;
  final bool? isLoading;
  final int? id;
  AddressAddEditLoadedState({
    required this.country,
    required this.city,
    required this.fullAddress,
    this.isDefault = false,
    this.id,
    this.isLoading = false,
  });

  AddressAddEditLoadedState copyWith({
    String? city,
    String? country,
    String? fullAddress,
    bool? isDefault,
    bool? isLoading,
    int? id,
  }) {
    return AddressAddEditLoadedState(
      city: city ?? this.city,
      id: id ?? this.id,
      country: country ?? this.country,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        city,
        country,
        fullAddress,
        isDefault,
        isLoading,
        id,
      ];
}
