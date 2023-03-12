part of 'product_bloc.dart';

abstract class ProductState extends Equatable {}

class InitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdding extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdded extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
  @override
  List<Object?> get props => [error];
}


class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  List<Product> productList;

  ProductLoaded(this.productList);
  @override
  List<Object?> get props => [productList];
}

// class ProductUpdating extends ProductState {
//   @override
//   List<Object?> get props => [];
// }

// class ProductUpdated extends ProductState {
//   @override
//   List<Object?> get props => [];
// }

class ProductDeleting extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductDeleted extends ProductState {
  @override
  List<Object?> get props => [];
}
