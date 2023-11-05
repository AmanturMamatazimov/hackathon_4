part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<ProductModel> products;
  final bool hasReachedMax;
  const CatalogLoaded({
    this.products = const [],
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        products,
        hasReachedMax,
      ];

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'posts': products.map((x) => x.toMap()).toList(),
  //     'hasReachedMax': hasReachedMax,
  //   };
  // }

  // factory CatalogLoaded.fromMap(Map<String, dynamic> map) {
  //   return CatalogLoaded(
  //     products: List<ProductModel>.from(
  //       (map['posts'] as List).map(
  //         (x) => ProductModel.fromMap(x),
  //       ),
  //     ),
  //     hasReachedMax: map['hasReachedMax'] as bool,
  //   );
  // }
}

class CatalogFailure extends CatalogState {
  final String errorText;
  const CatalogFailure({required this.errorText});

  @override
  List<Object> get props => [errorText];
}

class CatalogEmpty extends CatalogState {
  const CatalogEmpty();
}
