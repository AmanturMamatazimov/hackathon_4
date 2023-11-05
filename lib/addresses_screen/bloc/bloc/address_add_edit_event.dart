part of 'address_add_edit_bloc.dart';

abstract class AddressAddEditEvent extends Equatable {
  const AddressAddEditEvent();

  @override
  List<Object?> get props => [];
}

class AddressLoadedEvent extends AddressAddEditEvent {
  final String? city;
  final String? country;
  final String? fullAddress;
  final bool isDefault;
  final int? id;
  AddressLoadedEvent({
    this.city,
    this.id,
    this.country,
    this.fullAddress,
    this.isDefault = false,
  });
  @override
  List<Object?> get props => [
        city,
        country,
        fullAddress,
        isDefault,
        id,
      ];
}

class AddressEditCityEvent extends AddressAddEditEvent {
  const AddressEditCityEvent(this.text);
  final String text;

  List<Object> get props => [text];
}

class AddressEditCountryEvent extends AddressAddEditEvent {
  const AddressEditCountryEvent(this.text);
  final String text;

  List<Object> get props => [text];
}

class AddressEditAddressEvent extends AddressAddEditEvent {
  const AddressEditAddressEvent(this.text);
  final String text;

  List<Object> get props => [text];
}

class AddressEditDefaultEvent extends AddressAddEditEvent {
  const AddressEditDefaultEvent(this.value);
  final bool value;

  List<Object> get props => [value];
}

class AddressAddEvent extends AddressAddEditEvent {
  const AddressAddEvent({this.id});
  final int? id;
  List<Object?> get props => [id];
}

class AddressAddInitialEvent extends AddressAddEditEvent {
  const AddressAddInitialEvent();
}
