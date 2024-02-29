import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:excel/excel.dart';

class Car {
 late int id ;
 late int? enshuranceCode ;
 late String url ;
 late String model ;
 late String city ;
 late DateTime actualYear ;
 late int licenseYear;
 late int counter ;
 late String color ;
 late int price ;
 late bool? review ;
 late bool? repairImage ;
 late bool? enka ;
 late List<String> repairs ;
 late int repairsCount ;
 late String accessories1 ;
 late String accessories2 ;
 late String accessories3 ;
 late String accessories4 ;
 late String allAccessories ;
 late Map<String,bool> singleAccessories ;
 late int totalCostDollar ;
 late int totalCostEgp ;


 Car.fromRow(List<Data?> row,String name){
  id = int.parse(row[0]!.value.toString());
  model = name ;
  enshuranceCode =row[1]?.value==null? 99999999 : int.parse(row[1]!.value.toString());
  url = row[2]!.value.toString();
  city = row[3]!.value.toString();
  actualYear = getDateFromYearMonth(row[5]!.value.toString());
  licenseYear = actualYear.month>=6?actualYear.year+1:actualYear.year;
  counter = int.parse(row[6]!.value.toString());
  color = row[12]!.value.toString();
  price = int.parse(row[13]!.value.toString());
  review = row[14]?.value==null?false:true;
  repairImage = row[15]?.value==null?false:true;
  enka = row[16]?.value==null?false:true;
  repairs = row[17]!.value.toString().split("_x000D_").map((e) => e.trim()).toList();
  repairsCount = int.parse(row[18]!.value.toString());
  accessories1 = row[25]!.value.toString();
  accessories2 = row[26]!.value.toString();
  accessories3 = row[27]!.value.toString();
  accessories4 = row[28]!.value.toString();
  allAccessories = '  $accessories1  $accessories2  $accessories3  $accessories4 ';
  singleAccessories = getSingleAccessories(allAccessories: allAccessories);
  totalCostDollar = PriceCalculator.totalCostDollar(carPrice: double.parse(row[13]!.value.toString())).toInt();
  totalCostEgp = PriceCalculator.totalCostEgp(carPrice: double.parse(row[13]!.value.toString())).toInt();
  print(repairs);


 }


 Map<String,bool> getSingleAccessories ({required String allAccessories}){
 return  {
     AppStrings.accessories11   :allAccessories.contains(AppStrings.accessories11  ),
     AppStrings.accessories12   :allAccessories.contains(AppStrings.accessories12  ),
     AppStrings.accessories13   :allAccessories.contains(AppStrings.accessories13  ),
     AppStrings.accessories14   :allAccessories.contains(AppStrings.accessories14  ),
     AppStrings.accessories15   :allAccessories.contains(AppStrings.accessories15  ),
     AppStrings.accessories16   :allAccessories.contains(AppStrings.accessories16  ),
     AppStrings.accessories17   :allAccessories.contains(AppStrings.accessories17  ),
     AppStrings.accessories18   :allAccessories.contains(AppStrings.accessories18  ),
     AppStrings.accessories19   :allAccessories.contains(AppStrings.accessories19  ),
     AppStrings.accessories110  :allAccessories.contains(AppStrings.accessories110 ),
     AppStrings.accessories111  :allAccessories.contains(AppStrings.accessories111 ),
     AppStrings.accessories112  :allAccessories.contains(AppStrings.accessories112 ),
     AppStrings.accessories113  :allAccessories.contains(AppStrings.accessories113 ),
     AppStrings.accessories114  :allAccessories.contains(AppStrings.accessories114 ),
     AppStrings.accessories115  :allAccessories.contains(AppStrings.accessories115 ),
     AppStrings.accessories116  :allAccessories.contains(AppStrings.accessories116 ),
     AppStrings.accessories117  :allAccessories.contains(AppStrings.accessories117 ),
     AppStrings.accessories21   :allAccessories.contains(AppStrings.accessories21  ),
     AppStrings.accessories22   :allAccessories.contains(AppStrings.accessories22  ),
     AppStrings.accessories23   :allAccessories.contains(AppStrings.accessories23  ),
     AppStrings.accessories24   :allAccessories.contains(AppStrings.accessories24  ),
     AppStrings.accessories25   :allAccessories.contains(AppStrings.accessories25  ),
     AppStrings.accessories26   :allAccessories.contains(AppStrings.accessories26  ),
     AppStrings.accessories27   :allAccessories.contains(AppStrings.accessories27  ),
     AppStrings.accessories28   :allAccessories.contains(AppStrings.accessories28  ),
     AppStrings.accessories29   :allAccessories.contains(AppStrings.accessories29  ),
     AppStrings.accessories210  :allAccessories.contains(AppStrings.accessories210 ),
     AppStrings.accessories211  :allAccessories.contains(AppStrings.accessories211 ),
     AppStrings.accessories212  :allAccessories.contains(AppStrings.accessories212 ),
     AppStrings.accessories213  :allAccessories.contains(AppStrings.accessories213 ),
     AppStrings.accessories31   :allAccessories.contains(AppStrings.accessories31  ),
     AppStrings.accessories32   :allAccessories.contains(AppStrings.accessories32  ),
     AppStrings.accessories33   :allAccessories.contains(AppStrings.accessories33  ),
     AppStrings.accessories34   :allAccessories.contains(AppStrings.accessories34  ),
     AppStrings.accessories35   :allAccessories.contains(AppStrings.accessories35  ),
     AppStrings.accessories36   :allAccessories.contains(AppStrings.accessories36  ),
     AppStrings.accessories37   :allAccessories.contains(AppStrings.accessories37  ),
     AppStrings.accessories38   :allAccessories.contains(AppStrings.accessories38  ),
     AppStrings.accessories39   :allAccessories.contains(AppStrings.accessories39  ),
     AppStrings.accessories310  :allAccessories.contains(AppStrings.accessories310 ),
     AppStrings.accessories311  :allAccessories.contains(AppStrings.accessories311 ),
     AppStrings.accessories312  :allAccessories.contains(AppStrings.accessories312 ),
     AppStrings.accessories313  :allAccessories.contains(AppStrings.accessories313 ),
     AppStrings.accessories314  :allAccessories.contains(AppStrings.accessories314 ),
     AppStrings.accessories315  :allAccessories.contains(AppStrings.accessories315 ),
     AppStrings.accessories316  :allAccessories.contains(AppStrings.accessories316 ),
     AppStrings.accessories41   :allAccessories.contains(AppStrings.accessories41  ),
     AppStrings.accessories42   :allAccessories.contains(AppStrings.accessories42  ),
     AppStrings.accessories43   :allAccessories.contains(AppStrings.accessories43  ),
     AppStrings.accessories44   :allAccessories.contains(AppStrings.accessories44  ),
     AppStrings.accessories45   :allAccessories.contains(AppStrings.accessories45  ),
     AppStrings.accessories46   :allAccessories.contains(AppStrings.accessories46  ),
     AppStrings.accessories47   :allAccessories.contains(AppStrings.accessories47  ),
     AppStrings.accessories48   :allAccessories.contains(AppStrings.accessories48  ),
  };
 }

 DateTime getDateFromYearMonth(String yearMonth) {
   // Parse the year and month from the input string
   int year = int.parse(yearMonth.substring(0, 4));
   int month = int.parse(yearMonth.substring(4, 6));

   // Create a DateTime object with the provided year and month
   return DateTime(year, month);
 }

}