
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' ;
import '../../logic_code_machine/cars_classfication.dart';
import '../../logic_code_machine/excel_Management.dart';
import '../../../models/car.dart';


class PdfStaticsBuilder {
  final pdf = Document();



  Future<Uint8List> makePdf()  async {
    for(var singleList in ExcelManagement.carsLists){
      List<List<List<Car>>> singleClassifiedList = await CarsClassification(singleList).sortCars();
      String name = ExcelManagement.names[ExcelManagement.carsLists.indexOf(singleList)];
      await addPage(singleClassifiedList,name);
    }

    return pdf.save();

  }



  Future<void> addPage(List<List<List<Car>>> singleClassifiedList,String name) async {
    final theme = ThemeData.withFont(
        base: Font.ttf(
          await rootBundle.load('assets/fonts/Tajawal-Regular.ttf'),

        ),
        bold: Font.ttf(
          await rootBundle.load('assets/fonts/Tajawal-Bold.ttf'),
        ));


    pdf.addPage(Page(
        pageTheme: PageTheme(

          textDirection: TextDirection.rtl,
          theme: theme,
          pageFormat: PdfPageFormat.a4,

        ),
        build: (context)  {
          return   getWidgets(cars: singleClassifiedList,name: name) ;

        }
    ));

  }




  Widget getWidgets({required List<List<List<Car>>> cars,required String name}) {
    List<Widget> list = <Widget>[Text(name),SizedBox(height: 25)];
    for(var i = 0; i < cars.length; i++){
      list.add(singleRepair(cars[i], i));
    }
    return Column(
      children: list
    );
  }




  static Map<String,int> getMaxMin (List<Car> cars){
    List<int> prices =[];
    if(cars.isNotEmpty){
      for(Car car in cars){
        prices.add(car.price);
      }


      return {'max':prices.reduce((curr, next) => curr > next? curr: next),
        'min':prices.reduce((curr, next) => curr < next? curr: next),'count':cars.length};
    }else{
      return {'max':000,'min':0000,'count':0};
    }

  }




  static Widget singleRepair (List<List<Car>> cars,int repairsCount){
    List<Car> allcars = cars[0]+cars[1]+cars[2]+cars[3]+cars[4];
    Map<String,int> AllMaxMin = getMaxMin(allcars);

    Map<String,int> MaxMin0 = getMaxMin(cars[0]);
    Map<String,int> MaxMin1 = getMaxMin(cars[1]);
    Map<String,int> MaxMin2 = getMaxMin(cars[2]);
    Map<String,int> MaxMin3 = getMaxMin(cars[3]);
    Map<String,int> MaxMin4 = getMaxMin(cars[4]);

    return        Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text('( ${AllMaxMin['max']} - ${AllMaxMin['min']} )    ${AllMaxMin['count']}'),
                      SizedBox(height: 20),
                      Text('( ${MaxMin1['max']} - ${MaxMin1['min']} )    ${MaxMin1['count']}       :   ( 100 - 50 )',textDirection: TextDirection.rtl),
                      SizedBox(height: 10),

                      Text('( ${MaxMin3['max']} - ${MaxMin3['min']} )    ${MaxMin3['count']}       : ( 200 - 150 )'),

                    ]
                ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text('$repairsCount *'),
                      SizedBox(height: 20),
                      Text('( ${MaxMin0['max']} - ${MaxMin0['min']} )    ${MaxMin0['count']}       :      ( 50 - 0 )'),

                      SizedBox(height: 10),
                      Text('( ${MaxMin2['max']} - ${MaxMin2['min']} )    ${MaxMin2['count']}       : ( 150 - 100 )'),
                      SizedBox(height: 10),

                      Text('( ${MaxMin4['max']} - ${MaxMin4['min']} )    ${MaxMin4['count']}      : ( 250 - 200 )'),


                    ]
                ),


              ]
          ),
          if(repairsCount!=4)Padding(padding: const EdgeInsets.only(top:20,bottom: 20) ,child: Divider(thickness: .7,))

        ]
    ) ;
}



}
