import 'package:elgamalstatics/data/local/shared_preference.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import '../resources/routes_manager.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  Future<void> _getCatalog(BuildContext context) async {
    if( PriceCalculator.allNumbers != null ){
      await ExcelManagement.openFilePicker().then((value) {
        if(value==true){
          Navigator.pushNamed(context, Routes.carCatalogRoute);
        }
      });
    }else{
      Navigator.pushNamed(context, Routes.changeNumbersRoute);
    }
  }

  void _settings (BuildContext context){
    Navigator.pushNamed(context, Routes.settingsRoute);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          IconButton(onPressed: (){
            _settings(context);
          }, icon: const Icon(Icons.settings),tooltip: 'Settings'),
        ],

        title: const Text(AppStrings.elgamalcars),
      ),
      body: const Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getCatalog(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

