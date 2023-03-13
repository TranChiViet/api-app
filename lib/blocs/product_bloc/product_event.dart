part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class Create extends ProductEvent {
  final Product product;
  Create(
    this.product,
  );
  @override
  List<Object> get props => [product];
}

class GetData extends ProductEvent {
  GetData();
}

class Update extends ProductEvent {
  final Product product;
  Update(
    this.product,
  );
  @override
  List<Object> get props => [product];
}

class Delete extends ProductEvent {
  final Product product;

  Delete(
    this.product,
  );
  @override
  List<Object> get props => [product];
}
