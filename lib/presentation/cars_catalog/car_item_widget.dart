import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/pdf/pdf_client_car/pdf_client_car_builder.dart';
import 'package:elgamalstatics/presentation/resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cars_accessories_widget.dart';
class CarItem extends StatelessWidget {
  const CarItem( {Key? key,required this.carItem}) : super(key: key);
final Car carItem ;

void getReport(BuildContext context){
  PdfClientCarBuilder.car=carItem;
  Navigator.pushNamed(context, Routes.pdfClientCarRoute);
}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(height: 50,width: 50,child: Center(child: Column(
        children: [
          Row(children: [
            IconButton(onPressed: (){
              getReport(context);
            }, icon:  Icon(Icons.picture_as_pdf))
          ],),
          Text(carItem.id.toString()),
          Text(carItem.enshuranceCode.toString()),
          Text(carItem.repairsCount.toString()),
          Text(carItem.repairs.toString()),
          Text(carItem.counter.toString()),
          Text(carItem.enka.toString()),
          Text(carItem.model.toString()),
          Text(carItem.color.toString()),
          Text(carItem.city.toString()),
          Text(carItem.price.toString()),
          Text(carItem.totalCostDollar.toString()),
          Text(carItem.totalCostEgp.toString()),
          AccessoriesWidget(carItem: carItem,),



        ],
      )),),

    );
  }
}
