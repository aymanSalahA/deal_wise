import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/data/services/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio = Dio();

  ProductCubit(ProductService productService) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    const String apiUrl = 'https://accessories-eshop.runasp.net/api/products';

    try {
      final response = await dio.get(apiUrl);
      await Future.delayed(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = response.data;
        final dynamic rawList = data['items'];

        if (rawList is List) {
          List<ProductModel> products = rawList
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return ProductModel.fromJson(item);
                }
                return null;
              })
              .whereType<ProductModel>()
              .toList();

          emit(ProductSuccess(products));
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
}
