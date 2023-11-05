part of 'filter_products_bloc.dart';

abstract class FilterProductsEvent extends Equatable {
  const FilterProductsEvent();

  @override
  List<Object?> get props => [];
}

class FilterProductsLoadedEvent extends FilterProductsEvent {}

class FilterProductsMinPriceEvent extends FilterProductsEvent {
  final String price;
  const FilterProductsMinPriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

class FilterProductsMaxPriceEvent extends FilterProductsEvent {
  final String price;
  const FilterProductsMaxPriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

class FilterProductsAddFirstCategoriesEvent extends FilterProductsEvent {}

class FilterProductsAddPageEvent extends FilterProductsEvent {
  final int? id;
  final String categoryTitle;
  const FilterProductsAddPageEvent({
    required this.id,
    required this.categoryTitle,
  });
  @override
  List<Object?> get props => [id, categoryTitle];
}

class FilterProductsAddSizesPageEvent extends FilterProductsEvent {
  final List<Sizes> sizeType;
  const FilterProductsAddSizesPageEvent({
    required this.sizeType,
  });
  @override
  List<Object> get props => [sizeType];
}

class FilterProductsCheckIsParentsOnlyEvent extends FilterProductsEvent {
  final bool isParents;
  const FilterProductsCheckIsParentsOnlyEvent({
    required this.isParents,
  });
  @override
  List<Object?> get props => [isParents];
}

class FilterProductsRemovePageEvent extends FilterProductsEvent {
  final bool isDeletingRequired;
  const FilterProductsRemovePageEvent({
    required this.isDeletingRequired,
  });
  @override
  List<Object?> get props => [isDeletingRequired];
}

class FilterProductsCheckAllEvent extends FilterProductsEvent {
  final List<Category> categories;
  final int length;
  const FilterProductsCheckAllEvent({
    required this.categories,
    required this.length,
  });
  @override
  List<Object?> get props => [categories, length];
}

class FilterProductsCheckAllSizesEvent extends FilterProductsEvent {
  final List<Sizes> sizes;
  final int length;
  const FilterProductsCheckAllSizesEvent({
    required this.sizes,
    required this.length,
  });
  @override
  List<Object?> get props => [sizes, length];
}

class FilterProductsCheckEvent extends FilterProductsEvent {
  final Category category;
  const FilterProductsCheckEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class FilterProductsCheckSizeEvent extends FilterProductsEvent {
  final Sizes size;
  const FilterProductsCheckSizeEvent({
    required this.size,
  });
  @override
  List<Object> get props => [size];
}

class FilterProductsSeasonChangeEvent extends FilterProductsEvent {
  final int id;
  const FilterProductsSeasonChangeEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class FilterProductsFilterEvent extends FilterProductsEvent {}

class FilterProductsCloseEvent extends FilterProductsEvent {}

class FilterProductsThrowEvent extends FilterProductsEvent {}
