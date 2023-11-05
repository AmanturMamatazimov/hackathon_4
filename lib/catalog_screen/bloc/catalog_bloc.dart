import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khanbuyer_new_design/utils/helper.dart';
import 'package:repository/repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required CatalogRepository catalogRepository})
      : _catalogRepo = catalogRepository,
        super(CatalogInitial()) {
    on<CatalogLoadEvent>(
      _onCatalogFetched,
      transformer: bloc_concurrency.droppable(),
    );
  }
  final CatalogRepository _catalogRepo;
  int startIndex = 0;
  Future<void> _onCatalogFetched(
    CatalogLoadEvent event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      if (state is CatalogInitial || event.filter) {
        emit(CatalogLoading());
        final products = await _catalogRepo.getCatalog(0);
        products!.isEmpty
            ? emit(const CatalogEmpty())
            : emit(CatalogLoaded(
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
          final products = await _catalogRepo.getCatalog(startIndex);
          emit(CatalogLoaded(
            products: [...event.products, ...products!],
            hasReachedMax: products.isEmpty ? true : false,
          ));
        }
      }
    } on Exception catch (exc) {
      if (exc is CatalogRequestFailure) {
        emit(CatalogFailure(errorText: exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }
}
