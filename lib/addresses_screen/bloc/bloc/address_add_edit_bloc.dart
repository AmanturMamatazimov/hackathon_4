import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

import '../../../../utils/utils.dart';

part 'address_add_edit_event.dart';
part 'address_add_edit_state.dart';

class AddressAddEditBloc
    extends Bloc<AddressAddEditEvent, AddressAddEditState> {
  AddressAddEditBloc({
    required AuthRepository userRepository,
  })  : _userRepo = userRepository,
        super(AddressAddEditInitial()) {
    on<AddressLoadedEvent>(_loadItems);
    on<AddressAddEvent>(_addAddress);
    on<AddressEditCityEvent>(_editAddress);
    on<AddressEditCountryEvent>(_editStreet);
    on<AddressEditAddressEvent>(_editFullAddress);
    on<AddressEditDefaultEvent>(_checkDefaultAddress);
    on<AddressAddInitialEvent>(_reInitState);
  }
  final AuthRepository _userRepo;

  Future<void> _loadItems(
      AddressLoadedEvent event, Emitter<AddressAddEditState> emit) async {
    emit(AddressAddEditLoadedState(
      city: event.city ?? '',
      fullAddress: event.fullAddress ?? '',
      country: event.country ?? '',
    ));
  }

  Future<void> _reInitState(
      AddressAddInitialEvent event, Emitter<AddressAddEditState> emit) async {
    emit(AddressAddEditInitial());
  }

  Future<void> _addAddress(
      AddressAddEvent event, Emitter<AddressAddEditState> emit) async {
    final state = this.state;
    try {
      if (state is AddressAddEditLoadedState) {
        emit(state.copyWith(isLoading: true));
        final map = {
          "country": state.country,
          "city": state.city,
          "full_address": state.fullAddress,
          "postcode": "121122112211",
          "phone_number": _userRepo.user?.username,
          "recipient": _userRepo.user?.fullName,
          "is_default": state.isDefault == null || !state.isDefault! ? 0 : 1,
        };

        final address = event.id != null
            ? await _userRepo.editAddress(event.id!, map)
            : await _userRepo.addAddress(map);
        if (address != null) {
          emit(AddressAddEditSuccessState(address));
        }
      }
    } on Exception catch (exc) {
      if (exc is AddAddressRequestFailure) {
        emit(AddressAddEditErrorState(exc.text));
      }
      if (exc is AddAddressEditRequestFailure) {
        emit(AddressAddEditErrorState(exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

  Future<void> _editAddress(
      AddressEditCityEvent event, Emitter<AddressAddEditState> emit) async {
    final state = this.state;
    if (state is AddressAddEditLoadedState) {
      emit(state.copyWith(city: event.text));
    }
  }

  Future<void> _editStreet(
      AddressEditCountryEvent event, Emitter<AddressAddEditState> emit) async {
    final state = this.state;
    if (state is AddressAddEditLoadedState) {
      emit(state.copyWith(country: event.text));
    }
  }

  Future<void> _editFullAddress(
      AddressEditAddressEvent event, Emitter<AddressAddEditState> emit) async {
    final state = this.state;
    if (state is AddressAddEditLoadedState) {
      emit(state.copyWith(fullAddress: event.text));
    }
  }

  Future<void> _checkDefaultAddress(
      AddressEditDefaultEvent event, Emitter<AddressAddEditState> emit) async {
    final state = this.state;
    if (state is AddressAddEditLoadedState) {
      emit(state.copyWith(isDefault: event.value));
    }
  }
}
