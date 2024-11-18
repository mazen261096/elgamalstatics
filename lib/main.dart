import 'package:bloc/bloc.dart';
import 'package:elgamalstatics/app/app_prefs.dart';
import 'package:elgamalstatics/presentation/home/home.dart';
import 'package:elgamalstatics/presentation/home/splash_screen.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/routes_manager.dart';
import 'package:elgamalstatics/presentation/settings/change_numbers_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PriceCalculator.fetchNumbers();
  bool numbersSaved = await PriceCalculator.isNumberSaved();
  AppPreferences.windowsUserName= await AppPreferences.getWindowsUsername();




  Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    onGenerateRoute: RouteGenerator.getRoute,
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home:numbersSaved?
    SplashScreen()
    :
        ChangeNumbersScreen()
    ,
  ));
}


