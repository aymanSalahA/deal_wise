import 'dart:developer';

import 'package:deal_wise/features/home/data/models/offer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/offer_service.dart';
import 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  // ignore: unused_field
  final OfferService _service;
  OfferCubit(this._service) : super(OfferInitial());
  final Dio dio = Dio();
  Future<void> getOffers() async {
    emit(OfferLoading());
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await dio.get(
        'https://accessories-eshop.runasp.net/api/offers',
      );

      final data = response.data;
      final items = data['offers']['items'] as List<dynamic>;
      log('Offerdata: $items');

      final offers = items.map((item) => Offer.fromJson(item)).toList();

      emit(OfferSuccess(offers));
    } catch (e) {
      emit(OfferFailure(e.toString()));
    }
  }
}
