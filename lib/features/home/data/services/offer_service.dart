import 'package:dio/dio.dart';
import '../models/offer_model.dart';

class OfferService {
  final Dio _dio = Dio();

  Future<List<Offer>> fetchOffers() async {
    const String url = 'https://accessories-eshop.runasp.net/api/offers';
    final response = await _dio.get(url);
    final offersData = response.data;
    if (offersData == null) return [];

    final items = (offersData['offers']?['items'] as List?) ?? [];
    return items.map((e) => Offer.fromJson(e as Map<String, dynamic>)).toList();
  }
}
