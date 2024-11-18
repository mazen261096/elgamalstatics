import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/sort_logic.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortWidget extends StatelessWidget {
   SortWidget({Key? key}) : super(key: key);
final List<String> _sortList = [
   AppStrings.priceLowToHigh,
   AppStrings.priceHighToLow,
   AppStrings.counterLowToHigh,
   AppStrings.counterHighToLow,
   AppStrings.yearLowToHigh,
   AppStrings.yearHighToLow,
   AppStrings.fixLowToHigh,
   AppStrings.fixHighToLow,
   AppStrings.viewLowToHigh,
   AppStrings.viewHighToLow
];
void _sort(String? value,BuildContext context){
BlocProvider.of<CarCatalogCubit>(context).sort(value!);
}
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: DropdownButton(
        value: SortLogic.dropDownValue,
        onChanged: (String? value){
          SortLogic.dropDownValue=value!;
          _sort(value,context);

        },
          items:_sortList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
                child: Text(value)) ;
          } ,
       ).toList()),
    );
  }
}
