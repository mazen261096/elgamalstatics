import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/presentation/cars_catalog/cars_catalog_screen.dart';
import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/routes_manager.dart';
class FailedCarsWidget extends StatelessWidget {
  const FailedCarsWidget({super.key});

retry(BuildContext context){
  BlocProvider.of<CarCatalogCubit>(context).getCars(cars: CarsCatalogScreen.catalogCars).onError((error, stackTrace) => ConstWidgets.alertDialog(context: context, content: Text("$error"), title: 'Error'));
}
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          const Text('an error has occured try get cars again'),
          IconButton(onPressed:(){retry(context);}, icon: const Icon(Icons.refresh))


        ],
      ),
    );
  }
}
