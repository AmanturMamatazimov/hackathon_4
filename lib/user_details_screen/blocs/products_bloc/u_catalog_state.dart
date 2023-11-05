part of 'u_catalog_bloc.dart';

abstract class UserCatalogState extends Equatable {
  const UserCatalogState();

  @override
  List<Object> get props => [];
}

class UserCatalogInitial extends UserCatalogState {}

class UserCatalogLoading extends UserCatalogState {}

class UserCatalogLoaded extends UserCatalogState {
  final List<ProductModel> products;
  final bool hasReachedMax;
  const UserCatalogLoaded({
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

  // factory UserCatalogLoaded.fromMap(Map<String, dynamic> map) {
  //   return UserCatalogLoaded(
  //     products: List<ProductModel>.from(
  //       (map['posts'] as List).map(
  //         (x) => ProductModel.fromMap(x),
  //       ),
  //     ),
  //     hasReachedMax: map['hasReachedMax'] as bool,
  //   );
  // }
}

class UserCatalogFailure extends UserCatalogState {
  final String errorText;
  const UserCatalogFailure({required this.errorText});

  @override
  List<Object> get props => [errorText];
}

class UserCatalogEmpty extends UserCatalogState {
  const UserCatalogEmpty();
}
