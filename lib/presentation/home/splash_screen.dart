import 'package:elgamalstatics/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../logic_code_machine/excel_Management.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateCars();
  }


  initiateCars() async {
    await ExcelManagement.initiateElgamalCars();
    await ExcelManagement.initiateAllCars(onSheetLoadedCallback: () { setState(() {});  });
    await ExcelManagement.initiateElgamalCarsId();
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text('Loading ${ExcelManagement.sheetsLoaded.toString()} of ${ExcelManagement.allPaths.length}')
        ],
      ),
    ));
  }
}
