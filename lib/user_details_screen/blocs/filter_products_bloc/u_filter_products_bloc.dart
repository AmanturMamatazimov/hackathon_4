import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository/repository.dart';

import '../../../../utils/utils.dart';
import '../../user_details_screen.dart';

part 'u_filter_products_event.dart';
part 'u_filter_products_state.dart';

class UserFilterProductsBloc
    extends Bloc<UserFilterProductsEvent, UserFilterProductsState> {
  UserFilterProductsBloc({required CatalogRepository catalogRepository})
      : _catalogRepo = catalogRepository,
        super(UserFilterProductsInitial()) {
    on<UserFilterProductsStartedEvent>(_initFilter);
    on<UserFilterProductsLoadedEvent>(_loadCategories);
    on<UserFilterProductsMinPriceEvent>(_changedMinPrice);
    on<UserFilterProductsMaxPriceEvent>(_changedMaxPrice);
    on<UserFilterProductsAddPageEvent>(_addPage);
    on<UserFilterProductsAddFirstCategoriesEvent>(_addFirstCategoriesPage);
    on<UserFilterProductsRemovePageEvent>(_removePage);
    on<UserFilterProductsCheckEvent>(_checkCategory);
    on<UserFilterProductsCheckAllEvent>(_checkAllCategories);
    on<UserFilterProductsCheckIsParentsOnlyEvent>(_checkIsAllParents);
    on<UserFilterProductsCheckAllSizesEvent>(_checkAllSizes);
    on<UserFilterProductsAddSizesPageEvent>(_addSizesPage);
    on<UserFilterProductsCheckSizeEvent>(_checkSize);
    on<UserFilterProductsSeasonChangeEvent>(_changeSeason);
    on<UserFilterProductsFilterEvent>(_filter);
    on<UserFilterProductsCloseEvent>(_close);
    on<UserFilterProductsThrowEvent>(_throw);
  }
  final CatalogRepository _catalogRepo;
  final List<List<Category>> categoriesListInList = [];
  int pageLevel = 0;
  List<Category> categories = [];

  Future<void> _loadCategories(UserFilterProductsLoadedEvent event,
      Emitter<UserFilterProductsState> emit) async {
    try {
      List categoryTypesLength = [];
      final state = this.state;
      if (state is UserFilterProductsInitial) {
        emit(UserFilterProductsLoadingState());
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

        emit(UserFilterProductsLoadedState(
          pages: [const UserMainPage()],
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
        emit(UserFilterProductsFailureState(errorText: exc.text));
      }
    } on Object catch (e) {
      clog(e);
      rethrow;
    }
  }

  void _initFilter(UserFilterProductsStartedEvent event,
      Emitter<UserFilterProductsState> emit) {
    emit(UserFilterProductsInitial());
  }

  void _changedMinPrice(UserFilterProductsMinPriceEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      emit(
        state.copyWith(
          minPrice: event.price,
        ),
      );
    }
  }

  void _changedMaxPrice(UserFilterProductsMaxPriceEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      emit(state.copyWith(
        maxPrice: event.price,
      ));
    }
  }

  void _addFirstCategoriesPage(UserFilterProductsAddFirstCategoriesEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      pageLevel++;
      emit(state.copyWith(pages: [
        ...state.pages,
        UserCategoryPage(
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

  void _addPage(UserFilterProductsAddPageEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState && event.id != null) {
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
          UserCategoryPage(
            categories: list,
            categoryTitle: event.categoryTitle,
          ),
        ],
      ));
    }
  }

  void _addSizesPage(UserFilterProductsAddSizesPageEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      emit(state.copyWith(
        pages: [
          ...state.pages,
          UserSizesPage(
            sizes: event.sizeType,
          ),
        ],
      ));
    }
  }

  void _removePage(UserFilterProductsRemovePageEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;

    if (state is UserFilterProductsLoadedState) {
      pageLevel--;
      final newPages = [...state.pages];
      newPages.removeLast();

      emit(state.copyWith(
        pages: newPages,
      ));
    }
  }

  void _checkCategory(UserFilterProductsCheckEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

  void _checkSize(UserFilterProductsCheckSizeEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

  void _checkAllCategories(UserFilterProductsCheckAllEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

  void _checkAllSizes(UserFilterProductsCheckAllSizesEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

  void _checkIsAllParents(UserFilterProductsCheckIsParentsOnlyEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      emit(state.copyWith(
        isThereSpecialButton: !event.isParents,
      ));
    }
  }

  void _changeSeason(UserFilterProductsSeasonChangeEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

  void _filter(UserFilterProductsFilterEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
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

      _catalogRepo.setUserFilter(finishedFilter.join('&'));
      emit(state.copyWith(isAfterThrow: false));
    }
  }

  void _close(UserFilterProductsCloseEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      pageLevel = 0;
      emit(state.copyWith(
        pages: [UserMainPage()],
      ));
    }
  }

  void _throw(UserFilterProductsThrowEvent event,
      Emitter<UserFilterProductsState> emit) {
    final state = this.state;
    if (state is UserFilterProductsLoadedState) {
      pageLevel = 0;
      _catalogRepo.setUserFilter('');

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
  // UserFilterProductsState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     // final posts = List<Post>.from(
  //     //   (json['posts'] as List).map(
  //     //     (x) => Post.fromMap(x),
  //     //   ),
  //     // );
  //     return UserFilterProductsLoadedState.fromMap(json);
  //   } catch (e) {
  //     clog(e.toString());
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(UserFilterProductsState state) {
  //   if (state is UserFilterProductsLoadedState) {
  //     return state.toMap();
  //   } else {
  //     return null;
  //   }
  // }
}
