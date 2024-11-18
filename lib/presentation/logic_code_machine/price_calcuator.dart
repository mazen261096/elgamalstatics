import 'package:elgamalstatics/data/local/shared_preference_assistant.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';

class PriceCalculator {
  static late double checkCost ;
  static late double encarCost ;
  static late double shippingCost ;
  static late double customsClearanceCosts ;
  static late double transferCommisssion ;
  static late double wonPrice ;
  static late double dollarPrice ;
  static late double profits;
  static Map? allNumbers;


  static double totalCostDollar ({required double carPrice}){
    return  (
    (((carPrice+encarCost+checkCost)*1000)/wonPrice)  +
  (  (((carPrice+encarCost+checkCost)*1000)/wonPrice)   *  transferCommisssion)+
        shippingCost + customsClearanceCosts  + profits
  );
  }


  static double totalCostEgp ({required double carPrice}){
    return totalCostDollar(carPrice: carPrice)*dollarPrice;
  }

  static Future<bool> isNumberSaved () async {
    return await SharedPreferenceAssistant.isSharedSaved(AppStrings.calaculatorNumbers);
  }

  static Future<void> fetchNumbers() async {

     if(await isNumberSaved()){
       Map data =await SharedPreferenceAssistant.fetchSavedShared(AppStrings.calaculatorNumbers);
       allNumbers =data;
       checkCost = data['Check Cost'];
       encarCost = data['Encar Cost'];
       shippingCost = data['Shipping Cost'];
       customsClearanceCosts = data['Custom Clearnce Cost'];
       transferCommisssion = data['Transfer Commission'];
       wonPrice = data['Won Price'];
       dollarPrice = data['Dollar Price'];
       profits = data['Profits'];
     }

  }




}