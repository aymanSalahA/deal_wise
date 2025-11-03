import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/data/services/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio = Dio();
  final ProductService productService;

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  ProductCubit(this.productService) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    const String apiUrl = 'https://accessories-eshop.runasp.net/api/products';

    try {
      final response = await dio.get(apiUrl);
      await Future.delayed(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = response.data;
        final dynamic rawList = data['items'];

        if (rawList is List) {
          allProducts = rawList
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return ProductModel.fromJson(item);
                }
                return null;
              })
              .whereType<ProductModel>()
              .toList();

          filteredProducts = List.from(allProducts);

          emit(ProductSuccess(filteredProducts));
        } else {
          emit(
            ProductFailurer(
              'Failed to parse products list. Missing or invalid "items" key.',
            ),
          );
        }
      } else {
        emit(
          ProductFailurer(
            'Failed to load products. Status Code: ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      String errorMessage =
          e.response?.data.toString() ?? e.message ?? 'Unknown network error';
      emit(ProductFailurer('Network Error: $errorMessage'));
    } catch (e) {
      emit(ProductFailurer(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = List.from(allProducts);
    } else {
      filteredProducts = allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    emit(ProductSuccess(filteredProducts));
  }
}
