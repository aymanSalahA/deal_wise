import '../../data/models/offer_model.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferSuccess extends OfferState {
  final List<Offer> offers;
  OfferSuccess(this.offers);
}

class OfferFailure extends OfferState {
  final String message;
  OfferFailure(this.message);
}
