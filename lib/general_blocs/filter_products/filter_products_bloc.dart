import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

import '../../utils/utils.dart';
import '../../view/catalog_screen/catalog_screen.dart';

part 'filter_products_event.dart';
part 'filter_products_state.dart';

class FilterProductsBloc
    extends Bloc<FilterProductsEvent, FilterProductsState> {
  FilterProductsBloc({required CatalogRepository catalogRepository})
      : _catalogRepo = catalogRepository,
        super(FilterProductsInitial()) {
    on<FilterProductsLoadedEvent>(_loadCategories);
    on<FilterProductsMinPriceEvent>(_changedMinPrice);
    on<FilterProductsMaxPriceEvent>(_changedMaxPrice);
    on<FilterProductsAddPageEvent>(_addPage);
    on<FilterProductsAddFirstCategoriesEvent>(_addFirstCategoriesPage);
    on<FilterProductsRemovePageEvent>(_removePage);
    on<FilterProductsCheckEvent>(_checkCategory);
    on<FilterProductsCheckAllEvent>(_checkAllCategories);
    on<FilterProductsCheckIsParentsOnlyEvent>(_checkIsAllParents);
    on<FilterProductsCheckAllSizesEvent>(_checkAllSizes);
    on<FilterProductsAddSizesPageEvent>(_addSizesPage);
    on<FilterProductsCheckSizeEvent>(_checkSize);
    on<FilterProductsSeasonChangeEvent>(_changeSeason);
    on<FilterProductsFilterEvent>(_filter);
    on<FilterProductsCloseEvent>(_close);
    on<FilterProductsThrowEvent>(_throw);
  }
  final CatalogRepository _catalogRepo;
  final List<List<Category>> categoriesListInList = [];
  int pageLevel = 0;
  List<Category> categories = [];

  Future<void> _loadCategories(FilterProductsLoadedEvent event,
      Emitter<FilterProductsState> emit) async {
    try {
      List categoryTypesLength = [];
      final state = this.state;
      if (state is FilterProductsInitial) {
        emit(FilterProductsLoadingState());
        categories =
            (_catalogRepo.categories ?? await _catalogRepo.getCategories())!;
        for (var c in categories) {
          if (!categoryTypesLength.contains(c.parentId)) {
            categoryTypesLength.add(c.parentId);
            categoriesListInList.add([]);
          }
          final ind = categoryTypesLength.lastIndexOf(c.parentId); //-1 if error
          categoriesListInList[ind].add(c);
        }

        emit(FilterProductsLoadedState(
          pages: [const MainPage()],
          routePages: [
            const {
              'level': 0,
              'title': '',
            }
          ],
          chosenRoutePages: [],
          sizeTypes: [],
          chosenCategories: [],
          chosenSizeTypes: [],
          seasonIds: [],
          categoriesListInList: categoriesListInList,
        ));
      }
    } on Exception catch (exc) {
      if (exc is CatalogCategoriesRequestFailure) {
        emit(FilterProductsFailureState(errorText: exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

  void _changedMinPrice(
      FilterProductsMinPriceEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      emit(
        state.copyWith(
          minPrice: event.price,
        ),
      );
    }
  }

  void _changedMaxPrice(
      FilterProductsMaxPriceEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      emit(state.copyWith(
        maxPrice: event.price,
      ));
    }
  }

  void _addFirstCategoriesPage(FilterProductsAddFirstCategoriesEvent event,
      Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      pageLevel++;
      emit(state.copyWith(pages: [
        ...state.pages,
        CategoryPage(
          categories: categoriesListInList.first,
          categoryTitle: 'Категория',
        ),
      ], routePages: [
        ...state.routePages,
        {
          'level': pageLevel,
          'title': '',
        },
      ]));
    }
  }

  void _addPage(
      FilterProductsAddPageEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState && event.id != null) {
      pageLevel++;
      final list = state.categoriesListInList.firstWhere(
          (element) => element.any((e) => e.parentId == event.id),
          orElse: () => []);
      emit(state.copyWith(
        routePages: [
          ...state.routePages,
          {
            'level': pageLevel,
            'title': event.categoryTitle,
          },
        ],
        pages: [
          ...state.pages,
          CategoryPage(
            categories: list,
            categoryTitle: event.categoryTitle,
          ),
        ],
      ));
    }
  }

  void _addSizesPage(FilterProductsAddSizesPageEvent event,
      Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      emit(state.copyWith(
        pages: [
          ...state.pages,
          SizesPage(
            sizes: event.sizeType,
          ),
        ],
      ));
    }
  }

  void _removePage(
      FilterProductsRemovePageEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;

    if (state is FilterProductsLoadedState) {
      pageLevel--;
      final newPages = [...state.pages];
      newPages.removeLast();

      emit(state.copyWith(
        pages: newPages,
      ));
    }
  }

  void _checkCategory(
      FilterProductsCheckEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      final chosenCategories = [...state.chosenCategories];

      List<Map<String, dynamic>> list = [];
      if (chosenCategories.isNotEmpty) {
        final isOtherCategory = chosenCategories.any(
          (element) => element.parentId != event.category.parentId,
        );
        if (isOtherCategory) {
          chosenCategories.clear();
        }
      }
      for (var i = 0; i <= pageLevel; i++) {
        list.add(
            state.routePages.lastWhere((element) => element['level'] == i));
      }
      if (chosenCategories.contains(event.category)) {
        chosenCategories.remove(event.category);
      } else {
        chosenCategories.add(event.category);
      }
      emit(state.copyWith(
        chosenCategories: chosenCategories,
        sizeTypes: chosenCategories.isEmpty
            ? []
            : chosenCategories.first.sizeTypes.first.sizes,
        chosenRoutePages: list,
      ));
    }
  }

  void _checkSize(
      FilterProductsCheckSizeEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      final chosenSizes = [...?state.chosenSizeTypes];
      if (chosenSizes.contains(event.size)) {
        chosenSizes.remove(event.size);
      } else {
        chosenSizes.add(event.size);
      }

      emit(state.copyWith(
        chosenSizeTypes: chosenSizes,
      ));
    }
  }

  void _checkAllCategories(
      FilterProductsCheckAllEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      List<Category> chosenCategories = [...state.chosenCategories];
      List<Map<String, dynamic>> list = [];
      for (var i = 0; i <= pageLevel; i++) {
        list.add(
            state.routePages.lastWhere((element) => element['level'] == i));
      }
      if (chosenCategories.length == event.length) {
        chosenCategories.clear();
      } else {
        chosenCategories = [...event.categories];
      }
      emit(state.copyWith(
        chosenCategories: chosenCategories,
        sizeTypes: chosenCategories.isEmpty
            ? []
            : chosenCategories.first.sizeTypes.first.sizes,
        chosenRoutePages: list,
      ));
    }
  }

  void _checkAllSizes(FilterProductsCheckAllSizesEvent event,
      Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      List<Sizes> chosenSizes = [...?state.chosenSizeTypes];

      if (chosenSizes.length == event.length) {
        chosenSizes.clear();
      } else {
        chosenSizes = [...event.sizes];
      }
      emit(state.copyWith(
        chosenSizeTypes: chosenSizes,
      ));
    }
  }

  void _checkIsAllParents(FilterProductsCheckIsParentsOnlyEvent event,
      Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      emit(state.copyWith(
        isThereSpecialButton: !event.isParents,
      ));
    }
  }

  void _changeSeason(FilterProductsSeasonChangeEvent event,
      Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      final seasons = [...state.seasonIds];
      if (seasons.contains(event.id)) {
        seasons.remove(event.id);
      } else {
        seasons.add(event.id);
      }
      emit(state.copyWith(
        seasonIds: seasons,
      ));
    }
  }

  void _filter(
      FilterProductsFilterEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      Map initialFilters = {
        'category_ids': [...state.chosenCategories.map((e) => e.id)],
        'season_ids': [...state.seasonIds],
        'size_ids':
            state.chosenSizeTypes == null || state.chosenSizeTypes!.isEmpty
                ? null
                : [...state.chosenSizeTypes!.map((e) => e.id)],
        // 'gender_ids': [],
        'price_min': state.minPrice,
        'price_max': state.maxPrice,
        'size_group':
            state.chosenSizeTypes == null || state.chosenSizeTypes!.isEmpty
                ? null
                : state.chosenSizeTypes!.first.sizeTypeId,
      };
      List<String> finishedFilter = [];

      initialFilters.forEach((key, value) {
        if (value is List) {
          for (var element in value) {
            finishedFilter.add('ProductSearch[$key][]=$element');
          }
        } else {
          if (value != null && value.toString().isNotEmpty) {
            finishedFilter.add('ProductSearch[$key]=$value');
          }
        }
      });
      finishedFilter.removeWhere(
          (element) => element.endsWith('=null') || element.isEmpty);

      _catalogRepo.setFilter(finishedFilter.join('&'));
      emit(state.copyWith(isAfterThrow: false));
    }
  }

  void _close(
      FilterProductsCloseEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      pageLevel = 0;
      emit(state.copyWith(
        pages: [MainPage()],
      ));
    }
  }

  void _throw(
      FilterProductsThrowEvent event, Emitter<FilterProductsState> emit) {
    final state = this.state;
    if (state is FilterProductsLoadedState) {
      pageLevel = 0;
      _catalogRepo.setFilter('');

      emit(state.copyWith(
        routePages: [
          const {
            'level': 0,
            'title': '',
          }
        ],
        chosenRoutePages: [],
        chosenCategories: [],
        minPrice: '',
        maxPrice: '',
        sizeTypes: [],
        chosenSizeTypes: [],
        seasonIds: [],
        isAfterThrow: true,
      ));
    }
  }

  // @override
  // FilterProductsState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     // final posts = List<Post>.from(
  //     //   (json['posts'] as List).map(
  //     //     (x) => Post.fromMap(x),
  //     //   ),
  //     // );
  //     return FilterProductsLoadedState.fromMap(json);
  //   } catch (e) {
  //     clog(e.toString());
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(FilterProductsState state) {
  //   if (state is FilterProductsLoadedState) {
  //     return state.toMap();
  //   } else {
  //     return null;
  //   }
  // }
}
