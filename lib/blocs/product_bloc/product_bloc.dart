import 'package:api_app/repos/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(InitialState()) {
    on<Create>(_onCreate);
    on<GetData>(_onGetData);
    on<Delete>(_onDelete);
    on<Update>(_onUpdate);
  }

  void _onCreate(Create event, Emitter emit) async {
    emit(ProductAdding());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await productRepository.create(event.product);
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onGetData(GetData event, Emitter emit) async {
    emit(ProductLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final productList = await productRepository.get();
      emit(ProductLoaded(productList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onUpdate(Update event, Emitter emit) async {
    emit(ProductUpdating());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await productRepository.update(event.product);
      emit(ProductUpdated());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onDelete(Delete event, Emitter emit) async {
    emit(ProductDeleting());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await productRepository.delete(event.product);
      emit(ProductDeleted());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
   
  }
}


















