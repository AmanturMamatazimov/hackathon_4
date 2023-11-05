part of 'u_filter_products_bloc.dart';

abstract class UserFilterProductsEvent extends Equatable {
  const UserFilterProductsEvent();

  @override
  List<Object?> get props => [];
}

class UserFilterProductsStartedEvent extends UserFilterProductsEvent {}

class UserFilterProductsLoadedEvent extends UserFilterProductsEvent {}

class UserFilterProductsMinPriceEvent extends UserFilterProductsEvent {
  final String price;
  const UserFilterProductsMinPriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

class UserFilterProductsMaxPriceEvent extends UserFilterProductsEvent {
  final String price;
  const UserFilterProductsMaxPriceEvent(this.price);
  @override
  List<Object> get props => [price];
}

class UserFilterProductsAddFirstCategoriesEvent
    extends UserFilterProductsEvent {}

class UserFilterProductsAddPageEvent extends UserFilterProductsEvent {
  final int? id;
  final String categoryTitle;
  const UserFilterProductsAddPageEvent({
    required this.id,
    required this.categoryTitle,
  });
  @override
  List<Object?> get props => [id, categoryTitle];
}

class UserFilterProductsAddSizesPageEvent extends UserFilterProductsEvent {
  final List<Sizes> sizeType;
  const UserFilterProductsAddSizesPageEvent({
    required this.sizeType,
  });
  @override
  List<Object> get props => [sizeType];
}

class UserFilterProductsCheckIsParentsOnlyEvent
    extends UserFilterProductsEvent {
  final bool isParents;
  const UserFilterProductsCheckIsParentsOnlyEvent({
    required this.isParents,
  });
  @override
  List<Object?> get props => [isParents];
}

class UserFilterProductsRemovePageEvent extends UserFilterProductsEvent {
  final bool isDeletingRequired;
  const UserFilterProductsRemovePageEvent({
    required this.isDeletingRequired,
  });
  @override
  List<Object?> get props => [isDeletingRequired];
}

class UserFilterProductsCheckAllEvent extends UserFilterProductsEvent {
  final List<Category> categories;
  final int length;
  const UserFilterProductsCheckAllEvent({
    required this.categories,
    required this.length,
  });
  @override
  List<Object?> get props => [categories, length];
}

class UserFilterProductsCheckAllSizesEvent extends UserFilterProductsEvent {
  final List<Sizes> sizes;
  final int length;
  const UserFilterProductsCheckAllSizesEvent({
    required this.sizes,
    required this.length,
  });
  @override
  List<Object?> get props => [sizes, length];
}

class UserFilterProductsCheckEvent extends UserFilterProductsEvent {
  final Category category;
  const UserFilterProductsCheckEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class UserFilterProductsCheckSizeEvent extends UserFilterProductsEvent {
  final Sizes size;
  const UserFilterProductsCheckSizeEvent({
    required this.size,
  });
  @override
  List<Object> get props => [size];
}

class UserFilterProductsSeasonChangeEvent extends UserFilterProductsEvent {
  final int id;
  const UserFilterProductsSeasonChangeEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class UserFilterProductsFilterEvent extends UserFilterProductsEvent {}

class UserFilterProductsCloseEvent extends UserFilterProductsEvent {}

class UserFilterProductsThrowEvent extends UserFilterProductsEvent {}
