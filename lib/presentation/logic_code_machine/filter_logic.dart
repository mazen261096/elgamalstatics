import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../models/car.dart';

class FilterLogic {

  List<String>? availableColors ;
  List<String>? availableAcceptedAccessories ;
  List<String>? availableRejectedAccessories ;
  List<String> availableRepairsCount= const ['0','1','2','3','4','5','6','7'] ;
  List<String>? availableRejectedRepairs ;
  List<String>? availableModels ;
  List<String>? availableCity ;
  List<String>? availableNumbers ;
  List<String>? availableCompany ;
  List<String>? availableBrand ;
  List<String>? availableModel ;
  List<String>? availableLuxuryCategory ;
  List<String>? selectedColors ;
  List<String>? selectedAcceptedAccessories ;
  List<String>? selectedRejectedAccessories ;
  List<String>? selectedRepairsCount ;
  List<String>? selectedRejectedRepairs ;
  List<String>? selectedModels ;
  List<String>? selectedCity ;
  List<String>? selectedNumbers ;
  List<String>? selectedCompany ;
  List<String>? selectedBrand ;
  List<String>? selectedModel ;
  List<String>? selectedLuxuryCategory ;
  List<String>? luxuryCategory ;
  int? selectedPriceEgpFrom  ;
  int? selectedPriceEgpTo  ;
  int? selectedPriceDollarFrom  ;
  int? selectedPriceDollarTo  ;
  int? selectedYearFrom  ;
  int? selectedYearTo  ;
  int? selectedCounterFrom  ;
  int? selectedCounterTo  ;
  bool selectedReview = false  ;
  bool selectedEnka =false ;


  Future<void> initiateFilter({required List<Car> cars}) async{
    Set<String> nFilterColors = {};
    Set<String> nFilterAccessoriesTrue = {};
    Set<String> nFilterAccessoriesFalse = {};
    Set<String> nFilterRejectedRepairs = {};
    Set<String> nFilterModels = {};
    Set<String> nFilterCity = {};
    Set<String> nFilterNumbers = {};
    Set<String> nFilterCompany = {};
    Set<String> nFilterBrand = {};
    Set<String> nFilterModel = {};
    Set<String> nFilterLuxuryCategory = {};

    for(Car car in cars){
      nFilterColors.add(car.color);
      nFilterAccessoriesTrue.addAll(car.singleAccessories.keys.where((element) => car.singleAccessories[element]==true));
      nFilterAccessoriesFalse.addAll(car.singleAccessories.keys.where((element) => car.singleAccessories[element]==true));
      nFilterRejectedRepairs.addAll(car.repairs);
      nFilterModels.add(car.fileName!);
      nFilterCity.add(car.city);
      nFilterNumbers.add(car.contactNumber);
      nFilterCompany.add(car.company);
      nFilterBrand.add(car.brand);
      nFilterModel.add(car.model);
      nFilterLuxuryCategory.add(car.luxuryCategory);


    }
    availableColors=nFilterColors.toList();
    availableAcceptedAccessories=nFilterAccessoriesTrue.toList();
    availableRejectedAccessories=nFilterAccessoriesFalse.toList();
    availableRejectedRepairs=nFilterRejectedRepairs.toList();
    availableModels=nFilterModels.toList();
    availableModels=nFilterLuxuryCategory.toList();
    availableCity=nFilterCity.toList();
    availableNumbers=nFilterNumbers.toList();
    availableCompany=nFilterCompany.toList();
    availableBrand=nFilterBrand.toList();
    availableModel=nFilterModel.toList();
    availableLuxuryCategory=nFilterLuxuryCategory.toList();

  }


   List<MultiSelectItem>  toMultiSelect ({required List singleFilterList}){
   return singleFilterList.map((e) => MultiSelectItem(e, e==''?'فبريكا':e)).toList();
  }



  Future< List<Car> > filteredCars ({required List<Car> cars}) async{
    List<Car> filteredCars  = [];

    if(
    (selectedColors != null && selectedColors!.isNotEmpty )||
    (selectedAcceptedAccessories != null && selectedAcceptedAccessories!.isNotEmpty )||
    (selectedRejectedAccessories != null && selectedRejectedAccessories!.isNotEmpty )||
        (selectedRejectedRepairs != null && selectedRejectedRepairs!.isNotEmpty)||
        (selectedRepairsCount!=null && selectedRepairsCount!.isNotEmpty)||
        (selectedModels!=null && selectedModels!.isNotEmpty)||
        (selectedLuxuryCategory!=null && selectedLuxuryCategory!.isNotEmpty)||
        (selectedCity!=null && selectedCity!.isNotEmpty)||
        (selectedCompany!=null && selectedCompany!.isNotEmpty)||
        (selectedBrand!=null && selectedBrand!.isNotEmpty)||
        (selectedModel!=null && selectedModel!.isNotEmpty)||
        (selectedNumbers!=null && selectedNumbers!.isNotEmpty)||
        (selectedPriceDollarFrom!=null ) ||
        (selectedPriceDollarTo!=null ) ||
        (selectedPriceEgpFrom!=null ) ||
        (selectedPriceEgpTo!=null ) ||
        (selectedYearFrom!=null ) ||
        (selectedYearTo!=null ) ||
        (selectedCounterFrom!=null ) ||
        (selectedCounterTo!=null ) ||
        (selectedReview != false) ||
        (selectedEnka != false)

    ){

      filteredCars= cars.where((car) {

        return (

           ((selectedColors != null && selectedColors!.isNotEmpty )?selectedColors!.contains(car.color):true)&&
            ((selectedAcceptedAccessories != null && selectedAcceptedAccessories!.isNotEmpty )?allAccessoriesExist(selectedAcceptedAccessories!, car.allAccessories):true) &&
                ((selectedRejectedAccessories != null && selectedRejectedAccessories!.isNotEmpty )?allAccessoriesNotExist(selectedRejectedAccessories!, car.allAccessories):true)&&
               ((selectedRejectedRepairs != null&& selectedRejectedRepairs!.isNotEmpty)? rejectedRepairsExist(selectedRejectedRepairs!, car.repairs):true)&&
               ((selectedRepairsCount != null&& selectedRepairsCount!.isNotEmpty)? selectedRepairsCount!.contains(car.repairsCount.toString()):true)&&
               (        (selectedModels!=null && selectedModels!.isNotEmpty) ? selectedModels!.contains(car.fileName):true)&&
               (        (selectedCity!=null && selectedCity!.isNotEmpty) ? selectedCity!.contains(car.city):true)&&
               (        (selectedCompany!=null && selectedCompany!.isNotEmpty) ? selectedCompany!.contains(car.company):true)&&
               (        (selectedBrand!=null && selectedBrand!.isNotEmpty) ? selectedBrand!.contains(car.brand):true)&&
               (        (selectedModel!=null && selectedModel!.isNotEmpty) ? selectedModel!.contains(car.model):true)&&
               (        (selectedLuxuryCategory!=null && selectedLuxuryCategory!.isNotEmpty) ? selectedLuxuryCategory!.contains(car.luxuryCategory):true)&&
               (        (selectedNumbers!=null && selectedNumbers!.isNotEmpty) ? selectedNumbers!.contains(car.contactNumber):true)&&
               (        (selectedPriceDollarFrom!=null ) ? selectedPriceDollarFrom! <= car.totalCostDollar:true)&&
               (        (selectedPriceDollarTo!=null ) ? selectedPriceDollarTo! >= car.totalCostDollar:true)&&
               (        (selectedPriceEgpFrom!=null ) ? selectedPriceEgpFrom! <= car.totalCostEgp:true)&&
               (        (selectedPriceEgpTo!=null ) ? selectedPriceEgpTo! >= car.totalCostEgp:true  )&&
               (        (selectedYearFrom!=null ) ? selectedYearFrom! <= car.licenseYear:true    )&&
               (        (selectedYearTo!=null ) ? selectedYearTo! >= car.licenseYear:true)&&
               (        (selectedCounterFrom!=null ) ? selectedCounterFrom! <= car.counter:true)&&
               (        (selectedCounterTo!=null ) ? selectedCounterTo! >= car.counter:true) &&
               (        (selectedReview!=false ) ?  car.review==false :true) &&
               (        (selectedEnka!=false ) ? car.enka==true  :true)

        );

      }).toList();





    }else{
      return cars;
    }

    await initiateFilter(cars: filteredCars);


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

     if (mainString.contains(str)) {
       return false;
     }
   }
   return true;
 }

 static bool rejectedRepairsExist(List<String> selectedRepairs ,List<String> carRepairs){

   for(String singleRepair in selectedRepairs){
     if(carRepairs.contains(singleRepair)){
       return false ;
     }
   }
   return true;
 }




}