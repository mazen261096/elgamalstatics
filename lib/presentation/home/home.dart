import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import '../cars_catalog/cars_catalog_screen.dart';
import '../resources/routes_manager.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }





  Future<void> _getCatalog(
      {required BuildContext context, required List<Car> cars}) async {
    if (PriceCalculator.allNumbers != null) {
      CarsCatalogScreen.catalogCars = cars;
      Navigator.pushReplacementNamed(context, Routes.carCatalogRoute);
    } else {
      Navigator.pushNamed(context, Routes.changeNumbersRoute);
    }
  }

  void _settings(BuildContext context) {
    Navigator.pushNamed(context, Routes.settingsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _settings(context);
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings'),
        ],
        title: const Text(AppStrings.elgamalcars),
      ),
      body:GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                InkWell(
                  child: Card(
                    child: Center(
                      child: Text('Elgamal Cars' +
                          ' ( ${ExcelManagement.elgamalCars.length} )'),
                    ),
                  ),
                  onTap: () {
                    _getCatalog(
                        context: context, cars: ExcelManagement.elgamalCars);
                  },
                ),
                InkWell(
                  child: Card(
                    child: Center(
                      child: Text(
                          'From Excel ( ${ExcelManagement.allCars.length} )'),
                    ),
                  ),
                  onTap: () {
                    _getCatalog(
                        context: context, cars: ExcelManagement.allCars);
                  },
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
