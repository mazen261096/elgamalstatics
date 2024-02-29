import 'package:bloc/bloc.dart';
import 'package:elgamalstatics/presentation/home/home.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';


void main() {
  Bloc.observer = MyBlocObserver();
   PriceCalculator.fetchNumbers();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    onGenerateRoute: RouteGenerator.getRoute,
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home: const HomeScreen(),
  ));
}


