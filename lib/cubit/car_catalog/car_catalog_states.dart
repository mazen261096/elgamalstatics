import '../../models/car.dart';

abstract class CarCatalogStates{}
class CarCatalogIntialState extends CarCatalogStates{}
class CarCatalogGetCarsState extends CarCatalogStates{}
class CarCatalogGetCarsSuccessState extends CarCatalogStates{}
class CarCatalogGetCarsFailedState extends CarCatalogStates{}
class CarCatalogGetElgamalCarsState extends CarCatalogStates{}
class CarCatalogGetElgamalCarsSuccessState extends CarCatalogStates{}
class CarCatalogGetElgamalCarsFailedState extends CarCatalogStates{}
class CarBonusModifyState extends CarCatalogStates{}
class CarBonusModifiedState extends CarCatalogStates{
  final Car carItem;
  final double newPrice;
  CarBonusModifiedState({required this.carItem, required this.newPrice});
}
class CarBonusErrorState extends CarCatalogStates{
  final String message ;
  CarBonusErrorState(this.message);
}
class ElgamalPricingModifyState extends CarCatalogStates{}
class ElgamalPricingModifiedState extends CarCatalogStates{}
class ElgamalPricingModifyErrorState extends CarCatalogStates{}
