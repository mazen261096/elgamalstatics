import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../models/car.dart';

class FilterLogic {

 static List<String>? availableColors ;
 static List<String>? availableAcceptedAccessories ;
 static List<String>? availableRejectedAccessories ;
 static List<String> availableRepairesCount= const ['0','1','2','3','4','5','6','7'] ;
 static List<String>? availableRejectedRepaires ;
 static List<String>? availableModels ;
 static List<String>? selectedColors ;
 static List<String>? selectedAcceptedAccessories ;
 static List<String>? selectedRejectedAccessories ;
 static List<String>? selectedRepairesCount ;
 static List<String>? selectedeRejectedRepaires ;
 static List<String>? selectedeModels ;
 static int? selectedPriceEgpFrom  ;
 static int? selectedPriceEgpTo  ;
 static int? selectedPriceDollarFrom  ;
 static int? selectedPriceDollarTo  ;
 static int? selectedYearFrom  ;
 static int? selectedYearTo  ;


 static Future<void> initiateFilter({required List<Car> cars}) async{
    Set<String> nFilterColors = {};
    Set<String> nFilterAccessoriesTrue = {};
    Set<String> nFilterAccessoriesFalse = {};
    Set<String> nFilterRejectedRepairs = {};
    Set<String> nFilterModels = {};

    for(Car car in cars){
      nFilterColors.add(car.color);
      nFilterAccessoriesTrue.addAll(car.singleAccessories.keys.where((element) => car.singleAccessories[element]==true));
      nFilterAccessoriesFalse.addAll(car.singleAccessories.keys.where((element) => car.singleAccessories[element]==true));
      nFilterRejectedRepairs.addAll(car.repairs);
      nFilterModels.add(car.model);


    }
    availableColors=nFilterColors.toList();
    availableAcceptedAccessories=nFilterAccessoriesTrue.toList();
    availableRejectedAccessories=nFilterAccessoriesFalse.toList();
    availableRejectedRepaires=nFilterRejectedRepairs.toList();
    availableModels=nFilterModels.toList();

  }


  static List<MultiSelectItem>  toMultiSelect ({required List singleFilterList}){
   return singleFilterList.map((e) => MultiSelectItem(e, e==''?'فبريكا':e)).toList();
  }



 static Future< List<Car> > filteredCars ({required List<Car> cars}) async{
    List<Car> filteredCars  = [];

    if(
    (selectedColors != null && selectedColors!.isNotEmpty )||
    (selectedAcceptedAccessories != null && selectedAcceptedAccessories!.isNotEmpty )||
    (selectedRejectedAccessories != null && selectedRejectedAccessories!.isNotEmpty )||
        (selectedeRejectedRepaires != null && selectedeRejectedRepaires!.isNotEmpty)||
        (selectedRepairesCount!=null && selectedRepairesCount!.isNotEmpty)||
        (selectedeModels!=null && selectedeModels!.isNotEmpty)

    ){

      filteredCars= cars.where((car) {
       return (

           ((selectedColors != null && selectedColors!.isNotEmpty )?selectedColors!.contains(car.color):true)&&
            ((selectedAcceptedAccessories != null && selectedAcceptedAccessories!.isNotEmpty )?allAccessoriesExist(selectedAcceptedAccessories!, car.allAccessories):true) &&
                ((selectedRejectedAccessories != null && selectedRejectedAccessories!.isNotEmpty )?allAccessoriesNotExist(selectedRejectedAccessories!, car.allAccessories):true)&&
               ((selectedeRejectedRepaires != null&& selectedeRejectedRepaires!.isNotEmpty)? rejectedRepairsExist(selectedeRejectedRepaires!, car.repairs):true)&&
               ((selectedRepairesCount != null&& selectedRepairesCount!.isNotEmpty)? selectedRepairesCount!.contains(car.repairsCount.toString()):true)&&
               (        (selectedeModels!=null && selectedeModels!.isNotEmpty) ? selectedeModels!.contains(car.model):true)

        );

      }).toList();


    }else{
      return ExcelManagement.allCars;
    }



return filteredCars ;
}



static bool allAccessoriesExist(List<String> strings, String mainString) {
   for (String str in strings) {
     if (!mainString.contains(str)) {
       return false;
     }
   }
   return true;
 }

 static bool allAccessoriesNotExist(List<String> strings, String mainString) {

   for (String str in strings) {
     print('ssssssssssssssssssssssss $str');

     if (mainString.contains(str)) {
       return false;
     }
   }
   return true;
 }

 static bool rejectedRepairsExist(List<String> selectedRepairs ,List<String> carRepairs){
   print('ssssssssssssssssssssssss ');

   for(String singleRepair in selectedRepairs){
     if(carRepairs.contains(singleRepair)){
       return false ;
     }
   }
   return true;
 }




}