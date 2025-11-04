import 'package:flutter/foundation.dart';
import '../../data/models/product_model.dart';

class ProductCartAnimation extends ChangeNotifier {
  final ProductModel product;
  bool isFavorite;

  ProductCartAnimation({required this.product, this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

