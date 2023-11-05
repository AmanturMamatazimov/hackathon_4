// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_products_bloc.dart';

abstract class FilterProductsState extends Equatable {
  const FilterProductsState();

  @override
  List<Object?> get props => [];
}

class FilterProductsInitial extends FilterProductsState {}

class FilterProductsLoadingState extends FilterProductsState {}

class FilterProductsLoadedState extends FilterProductsState {
  final List<Map<String, dynamic>> routePages;
  final List<Map<String, dynamic>> chosenRoutePages;
  final List<Widget> pages;
  final List<int> seasonIds;
  final List<List<Category>> categoriesListInList;
  final List<Category> chosenCategories;
  final List<Sizes> sizeTypes;
  final List<Sizes>? chosenSizeTypes;
  final String minPrice;
  final String maxPrice;
  final bool isThereSpecialButton;
  final bool isAfterThrow;
  const FilterProductsLoadedState({
    required this.routePages,
    required this.chosenRoutePages,
    required this.pages,
    required this.categoriesListInList,
    required this.chosenCategories,
    required this.seasonIds,
    this.chosenSizeTypes,
    this.minPrice = '',
    this.maxPrice = '',
    required this.sizeTypes,
    this.isThereSpecialButton = false,
    this.isAfterThrow = false,
  });
  @override
  List<Object?> get props => [
        routePages,
        chosenRoutePages,
        chosenCategories,
        minPrice,
        maxPrice,
        categoriesListInList,
        sizeTypes,
        pages,
        chosenSizeTypes,
        seasonIds,
        isThereSpecialButton,
        isAfterThrow,
      ];

  FilterProductsLoadedState copyWith({
    List<Map<String, dynamic>>? routePages,
    List<Map<String, dynamic>>? chosenRoutePages,
    List<Widget>? pages,
    List<Category>? chosenCategories,
    String? minPrice,
    String? maxPrice,
    List<List<Category>>? categoriesListInList,
    List<Sizes>? sizeTypes,
    List<Sizes>? chosenSizeTypes,
    bool? isThereSpecialButton,
    List<int>? seasonIds,
    bool? isAfterThrow,
  }) {
    return FilterProductsLoadedState(
      chosenRoutePages: chosenRoutePages ?? this.chosenRoutePages,
      routePages: routePages ?? this.routePages,
      pages: pages ?? this.pages,
      chosenCategories: chosenCategories ?? this.chosenCategories,
      categoriesListInList: categoriesListInList ?? this.categoriesListInList,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sizeTypes: sizeTypes ?? this.sizeTypes,
      chosenSizeTypes: chosenSizeTypes ?? this.chosenSizeTypes,
      isThereSpecialButton: isThereSpecialButton ?? this.isThereSpecialButton,
      seasonIds: seasonIds ?? this.seasonIds,
      isAfterThrow: isAfterThrow ?? this.isAfterThrow,
    );
  }

  // factory FilterProductsLoadedState.fromMap(Map<String, dynamic> map) {
  //   return FilterProductsLoadedState(
  //     // posts: List<Post>.from(
  //     //   (map['posts'] as List).map(
  //     //     (x) => Post.fromMap(x),
  //     //   ),
  //     // ),
  //     // hasReachedMax: map['hasReachedMax'] as bool,
  //     chosenSizeTypes: List<Sizes>.from(
  //         (map['chosenSizeTypes'] as List).map((e) => Sizes.fromMap(e))),
  //     minPrice: map['minPrice'] as String, maxPrice: map['maxPrice'] as String,
  //     isThereSpecialButton: map['isThereSpecialButton'] as bool,
  //     categoriesListInList: List<List<Category>>.from(
  //         (map['categoriesListInList'] as List<List>).map(
  //             (e) => List<Category>.from(e.map((e2) => Category.fromMap(e2))))),
  //     chosenCategories: List<Category>.from(
  //         (map['chosenCategories'] as List).map((e) => Category.fromMap(e))),
  //     chosenRoutePages:
  //         List<Map<String, dynamic>>.from(map['chosenRoutePages']),
  //     pages: [MainPage()],
  //     routePages: List<Map<String, dynamic>>.from(map['routePages']),
  //     seasonIds: List<int>.from(map['seasonIds']),
  //     sizeTypes: List<Sizes>.from(
  //         (map['sizeTypes'] as List).map((e) => Sizes.fromMap(e))),
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'chosenSizeTypes': chosenSizeTypes?.map((x) => x.toMap()).toList(),
  //     'minPrice': minPrice,
  //     'maxPrice': maxPrice,
  //     'isThereSpecialButton': isThereSpecialButton,
  //     'categoriesListInList': categoriesListInList
  //         .map((e) => e.map((e2) => e2.toMap()).toList())
  //         .toList(),
  //     'chosenCategories': chosenCategories.map((e) => e.toMap()).toList(),
  //     'chosenRoutePages': chosenRoutePages,
  //     // 'pages': pages.map((e) => e.toString()),
  //     'routePages': routePages,
  //     'seasonIds': seasonIds,
  //     'sizeTypes': sizeTypes.map((e) => e.toMap()).toList(),
  //   };
  // }
}

class FilterProductsFailureState extends FilterProductsState {
  final String errorText;
  const FilterProductsFailureState({required this.errorText});
  @override
  List<Object> get props => [errorText];
}
