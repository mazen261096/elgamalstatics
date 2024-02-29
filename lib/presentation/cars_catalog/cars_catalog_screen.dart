import 'package:elgamalstatics/presentation/cars_catalog/cars_catalog_widget.dart';
import 'package:elgamalstatics/presentation/cars_catalog/failed_cars_widget.dart';
import 'package:elgamalstatics/presentation/cars_catalog/filter_catalog_widget.dart';
import 'package:elgamalstatics/presentation/cars_catalog/waiting_cars_widget.dart';
import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/car_catalog/car_catalog_cubit.dart';
import '../../cubit/car_catalog/car_catalog_states.dart';
import '../logic_code_machine/excel_Management.dart';
import '../resources/routes_manager.dart';



class CarsCatalogScreen extends StatelessWidget {
  const CarsCatalogScreen({Key? key}) : super(key: key);

  Widget showWidget(
      {required CarCatalogStates state, required BuildContext context}) {
    switch (state.runtimeType) {
      case CarCatalogGetCarsState:
        return const WaitingCarsWidget();

      case CarCatalogGetCarsSuccessState:
        return  CarsCatalogWidget();

      case CarCatalogGetCarsFailedState:
        return const FailedCarsWidget();

      default:
        return Container();
    }
  }

  void _showStatics(BuildContext context) {
    Navigator.pushNamed(context, Routes.pdfStaticsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarCatalogCubit>(
      create: (BuildContext context) => CarCatalogCubit()
        ..getCars().onError((error, stackTrace) =>
            ConstWidgets.alertDialog(
                context: context, message: "$error", title: 'Error')),
      child: BlocConsumer<CarCatalogCubit, CarCatalogStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state is CarCatalogGetCarsSuccessState?Text(
                  'cars Catalog (${BlocProvider.of<CarCatalogCubit>(context).cars.length})'):const Text('Cars Catalog')
            ),
            body: showWidget(context: context, state: state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showStatics(context);
              },
              child: const Icon(Icons.note_alt_sharp),
            ),
          );
        },
      ),
    );
  }
}
