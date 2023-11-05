import 'package:bloc/bloc.dart';
import 'package:repository/repository.dart';

class AddressCubit extends Cubit<AddressesModel?> {
  AddressCubit({
    required AuthRepository userRepository,
  })  : _userRepo = userRepository,
        super(null);
  final AuthRepository _userRepo;

  void setAddress(AddressesModel address) {
    _userRepo.setChosenAddress(address);
    emit(address);
  }
}
