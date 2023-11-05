import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khanbuyer_new_design/utils/helper.dart';
import 'package:repository/repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'u_catalog_event.dart';
part 'u_catalog_state.dart';

class UserCatalogBloc extends Bloc<UserCatalogEvent, UserCatalogState> {
  UserCatalogBloc({required CatalogRepository catalogRepository})
      : _catalogRepo = catalogRepository,
        super(UserCatalogInitial()) {
    on<UserCatalogLoadEvent>(
      _onUserCatalogFetched,
      transformer: bloc_concurrency.droppable(),
    );
    on<UserCatalogStartEvent>(_onUserCatalogStarted);
  }
  final CatalogRepository _catalogRepo;
  int startIndex = 0;
  Future<void> _onUserCatalogFetched(
    UserCatalogLoadEvent event,
    Emitter<UserCatalogState> emit,
  ) async {
    try {
      if (state is UserCatalogInitial || event.filter) {
        emit(UserCatalogLoading());
        final products = await _catalogRepo.getUserCatalog(0);
        products!.isEmpty
            ? emit(const UserCatalogEmpty())
            : emit(UserCatalogLoaded(
                products: products,
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
          final products = await _catalogRepo.getUserCatalog(startIndex);
          emit(UserCatalogLoaded(
            products: [...event.products, ...products!],
            hasReachedMax: products.isEmpty ? true : false,
          ));
        }
      }
    } on Exception catch (exc) {
      if (exc is UserCatalogRequestFailure) {
        emit(UserCatalogFailure(errorText: exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

  void _onUserCatalogStarted(
    UserCatalogStartEvent event,
    Emitter<UserCatalogState> emit,
  ) {
    emit(UserCatalogInitial());
  }
}
