import 'dart:io';

import 'package:elgamalstatics/presentation/cars_catalog/cars_catalog_widget.dart';
import 'package:elgamalstatics/presentation/cars_catalog/failed_cars_widget.dart';
import 'package:elgamalstatics/presentation/cars_catalog/filter_catalog_widget.dart';
import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/car_catalog/car_catalog_cubit.dart';
import '../../cubit/car_catalog/car_catalog_states.dart';
import '../../models/car.dart';
import '../logic_code_machine/excel_Management.dart';
import '../resources/routes_manager.dart';



class CarsCatalogScreen extends StatelessWidget {
  const CarsCatalogScreen({Key? key}) : super(key: key);
  static late List<Car> catalogCars ;

  Widget showWidget(
      {required CarCatalogStates state, required BuildContext context}) {
    switch (state.runtimeType) {
      case CarCatalogGetCarsState:
        return const Center(child: CircularProgressIndicator());

      case CarCatalogGetCarsFailedState:
        return const FailedCarsWidget();

      default:
        return CarsCatalogWidget();
    }
  }

  void _showStatics(BuildContext context) {
    Navigator.pushNamed(context, Routes.pdfStaticsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarCatalogCubit>(
      create: (BuildContext context)  => CarCatalogCubit()..getCars(cars: catalogCars)
      ,
      child: BlocConsumer<CarCatalogCubit, CarCatalogStates>(
        listener: (context, state) {
          if (state is CarBonusModifiedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تعديل السعر بنجاح!')),
            );
          }
          if (state is CarBonusErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return PopScope(

            canPop: true,
            onPopInvoked: (bool didPop){
              Navigator.pushReplacementNamed(context, Routes.homeRoute);
            },
            child: Scaffold(

              appBar: AppBar(

                title: Row(
                  children: [
                    Row(
                      children: [IconButton(onPressed:(){              Navigator.pushReplacementNamed(context, Routes.homeRoute);
                      } , icon: Icon(Icons.arrow_back_ios_new))
                        ,
                        Text('cars Catalog (${BlocProvider.of<CarCatalogCubit>(context).cars.length})')],
                    )

                  ],
                )
              ),
              body: showWidget(state: state, context: context),
            ),
          );
        },
      ),
    );
  }
}
