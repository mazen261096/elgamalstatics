import 'package:elgamalstatics/presentation/resources/strings_manager.dart';

import '../../models/car.dart';

class SortLogic{

  static String dropDownValue = 'Price Low' ;


  static Future<List<Car>> sort(List<Car> cars,String sortType) async {
    switch(sortType){
      case  AppStrings.priceLowToHigh :
        return await _priceLowToHigh(cars);
      case  AppStrings.priceHighToLow :
        return await _priceHighToLow(cars);
      case  AppStrings.counterLowToHigh :
        return await _counterLowToHigh(cars);
      case  AppStrings.counterHighToLow :
        return await _counterHighToLow(cars);
      case  AppStrings.yearLowToHigh :
        return await _yearLowToHigh(cars);
      case  AppStrings.yearHighToLow :
        return await _yearHighToLow(cars);
      case  AppStrings.fixLowToHigh :
        return await _fixLowToHigh(cars);
      case  AppStrings.fixHighToLow :
        return await _fixHighToLow(cars);
      case  AppStrings.viewLowToHigh :
        return await _viewLowToHigh(cars);
      case  AppStrings.viewHighToLow :
        return await _viewHighToLow(cars);
    }
    return cars ;

  }


 static Future<List<Car>> _priceLowToHigh (List<Car> cars) async{

    cars.sort((a,b)=>a.price.compareTo(b.price));
    return cars;

  }

 static Future<List<Car>> _priceHighToLow (List<Car> cars) async{
   cars.sort((a,b)=>b.price.compareTo(a.price));
   return cars;
 }

 static Future<List<Car>> _counterHighToLow (List<Car> cars) async{
    cars.sort((a,b)=>b.counter.compareTo(a.counter));
    return cars;
  }

 static Future<List<Car>> _counterLowToHigh (List<Car> cars) async{

   cars.sort((a,b)=>a.counter.compareTo(b.counter));
   return cars;

 }

 static Future<List<Car>> _yearLowToHigh (List<Car> cars) async{

   cars.sort((a,b)=>a.actualYear.compareTo(b.actualYear));
   return cars;

 }


 static Future<List<Car>> _yearHighToLow (List<Car> cars) async{
   cars.sort((a,b)=>b.actualYear.compareTo(a.actualYear));
   return cars;
 }





 static Future<List<Car>> _fixLowToHigh (List<Car> cars) async{

   cars.sort((a,b)=>a.repairsCount.compareTo(b.repairsCount));
   return cars;

 }

 static Future<List<Car>> _fixHighToLow (List<Car> cars) async{
   cars.sort((a,b)=>b.repairsCount.compareTo(a.repairsCount));
   return cars;
 }

 static Future<List<Car>> _viewLowToHigh (List<Car> cars) async{

   cars.sort((a,b)=>a.price.compareTo(b.price));
   return cars;

 }

 static Future<List<Car>> _viewHighToLow (List<Car> cars) async{
   cars.sort((a,b)=>b.price.compareTo(a.price));
   return cars;
 }





}