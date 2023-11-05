part of 'u_catalog_bloc.dart';

abstract class UserCatalogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserCatalogStartEvent extends UserCatalogEvent {}

class UserCatalogLoadEvent extends UserCatalogEvent {
  UserCatalogLoadEvent(
      {this.products = const [],
      this.isRefresh = false,
      this.hasReachedMax = false,
      this.filter = false,
      this.isLoadMore = false});
  final List<ProductModel> products;
  final bool isRefresh;
  final bool isLoadMore;
  final bool filter;
  final bool hasReachedMax;
  @override
  List<Object> get props =>
      [products, isRefresh, isLoadMore, hasReachedMax, filter];
}
