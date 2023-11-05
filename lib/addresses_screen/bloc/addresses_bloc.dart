import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

import '../../../utils/utils.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc({
    required AuthRepository userRepository,
    required OrdersRepository ordersRepository,
  })  : _userRepo = userRepository,
        _ordersRepo = ordersRepository,
        super(AddressesInitialState()) {
    on<AddressesLoadEvent>(_loadItems);
    on<MakeOrderEvent>(_makeOrder);
    on<AddressesRestartEvent>(_restartStates);
    on<AddressesNewAddress>(_addNewAddress);
    on<AddressesDeleteEvent>(_deleteAddress);
  }
  final AuthRepository _userRepo;
  final OrdersRepository _ordersRepo;
  int startIndex = 0;
  Future<void> _loadItems(
    AddressesLoadEvent event,
    Emitter<AddressesState> emit,
  ) async {
    try {
      if (!event.isRefresh && _userRepo.user != null) {
        emit(AddressesLoadedState(
            addresses: _userRepo.user!.addresses, hasReachedMax: true));
      } else {
        // if (_userRepo.isAfterRegister) {
        //   _userRepo.setAfterRegisterValue();
        // }
        if (state is AddressesInitialState) {
          emit(AddressesLoadingState());
          final addresses = await _userRepo.getAddresses(0);
          addresses!.isEmpty
              ? emit(AddressesEmptyState())
              : emit(AddressesLoadedState(
                  addresses: addresses,
                  hasReachedMax: false,
                ));
        } else {
          if (event.hasReachedMax) return;
          if (event.isRefresh || event.isLoadMore) {
            if (event.isRefresh) {
              startIndex = 0;
            } else {
              startIndex++;
            }
            final List<AddressesModel>? addresses =
                await _userRepo.getAddresses(startIndex);
            emit(AddressesLoadedState(
              addresses: [...event.addresses, ...addresses!],
              hasReachedMax: addresses.isEmpty ? true : false,
            ));
          }
        }
      }
    } on Exception catch (exc) {
      if (exc is AddressesRequestFailure) {
        emit(AddressesGetErrorState(errorText: exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

  Future<void> _makeOrder(
      MakeOrderEvent event, Emitter<AddressesState> emit) async {
    try {
      final state = this.state;
      if (state is AddressesLoadedState) {
        emit(state.copyWith(isMakingOrder: true));
        final address = _userRepo.chosenAddress!;
        Map<String, dynamic> data = {
          'order[recipient_name]': address.recipient,
          'order[recipient_phone_number]': address.phoneNumber,
          'order[recipient_address]':
              '${address.country}, г. ${address.city}, ${address.fullAddress}',
        };
        int itemIndex = 1;
        for (final c in event.colors) {
          data.addAll(
              {'order[items][$itemIndex][product_id]': '${c.productId}'});
          data.addAll({'order[items][$itemIndex][color_id]': '${c.id}'});
          data.addAll({'order[items][$itemIndex][quantity]': '${c.count}'});
          itemIndex++;
        }
        final order = await _ordersRepo.makeOrder(data);
        if (order != null) {
          emit(state.copyWith(makedOrder: order, isMakingOrder: false));
        }
      }
    } on Exception catch (exc) {
      final state = this.state;
      if (exc is AddressesRequestFailure) {
        emit(AddressesGetErrorState(errorText: exc.text));
      } else if (exc is OrderMakeRequestFailure) {
        if (state is AddressesLoadedState) {
          emit(
            state.copyWith(
              makedOrder: null,
              makingOrderError: exc.text,
              isMakingOrder: false,
            ),
          );
        }
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

//  ПРОВЕРИТЬ ЛУЧШЕ ДО НАЧАЛЬНОГО СТЕЙТА ВОЗВРАЩАТЬ ИЛИ НИЖНИМ МЕТОДОМ
  void _restartStates(
      AddressesRestartEvent event, Emitter<AddressesState> emit) {
    final state = this.state;
    if (state is AddressesLoadedState) {
      emit(AddressesLoadedState(
        addresses: state.addresses,
        hasReachedMax: false,
        isMakingOrder: false,
        makedOrder: null,
        makingOrderError: null,
      ));
    }
  }

  void _addNewAddress(AddressesNewAddress event, Emitter<AddressesState> emit) {
    final state = this.state;
    if (state is AddressesLoadedState) {
      final addresses = [...state.addresses, event.address];
      emit(state.copyWith(addresses: addresses));
    }
  }

  void _deleteAddress(
      AddressesDeleteEvent event, Emitter<AddressesState> emit) async {
    try {
      final state = this.state;
      if (state is AddressesLoadedState) {
        emit(state.copyWith(deletedAddressid: event.id));
        final success = await _userRepo.deleteAddress(event.id);
        if (success) {
          emit(state.copyWith(
              addresses: [...state.addresses]
                ..removeWhere((element) => element.id == event.id),
              errorWhileDeleting: ''));
        }
      }
    } on Exception catch (exc) {
      final state = this.state;
      if (state is AddressesLoadedState) {
        if (exc is AddressDeleteFailure) {
          emit(state.copyWith(errorWhileDeleting: exc.text));
        }
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }
}
