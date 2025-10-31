import 'package:deal_wise/features/home/data/models/product_model.dart';


abstract class ProductState  {
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductFailurer extends ProductState {
  final String message;

  ProductFailurer(this.message);

  @override
  List<Object?> get props => [message];
}
