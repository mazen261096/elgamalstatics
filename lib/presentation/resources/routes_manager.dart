
import 'package:elgamalstatics/presentation/cars_catalog/cars_catalog_screen.dart';
import 'package:elgamalstatics/presentation/cars_catalog/gallay_screen.dart';
import 'package:elgamalstatics/presentation/home/home.dart';
import 'package:elgamalstatics/presentation/home/splash_screen.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/pdf/pdf_client_car/pdf_client_car_screen.dart';
import 'package:elgamalstatics/presentation/pdf/pdf_statics_cars/pdf_statics_screen.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:elgamalstatics/presentation/settings/change_elgamal_pricing.dart';
import 'package:elgamalstatics/presentation/settings/change_numbers_Screen.dart';
import 'package:elgamalstatics/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';




class Routes {
  static const String homeScreenRoute = "/";
  static const String homeRoute = "/home";
  static const String carCatalogRoute = "/carCatalog";
  static const String pdfStaticsRoute = "/PdfStaticScreen";
  static const String pdfClientCarRoute = "/PdfClientCarScreen";
  static const String settingsRoute = "/settings";
  static const String changeNumbersRoute = "/changeNumbers";
  static const String changeElgamalNumbersRoute = "/changeElgamalNumbers";
}

class RouteGenerator {

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (_) =>   SplashScreen());
    case Routes.homeRoute:
    return MaterialPageRoute(builder: (_) =>   HomeScreen());
      case Routes.carCatalogRoute:
        return MaterialPageRoute(builder: (_) =>  const CarsCatalogScreen());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) =>  const SettingsScreen());
      case Routes.changeNumbersRoute:
        return MaterialPageRoute(builder: (_) =>  const ChangeNumbersScreen());
      case Routes.changeElgamalNumbersRoute:
        return MaterialPageRoute(builder: (_) =>   ElgamalPricingScreen());
      case Routes.pdfStaticsRoute:
        return MaterialPageRoute(builder: (_) =>  const PdfStaticsScreen());
      case Routes.pdfClientCarRoute:
        return MaterialPageRoute(builder: (_) =>  const PdfClientCarScreen());
      default:
        return unDefinedRoute();
    }
  }


  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteManager),
          ),
          body: const Center(
            child: Text(AppStrings.noRouteManager),
          ),
        ));
  }
}
