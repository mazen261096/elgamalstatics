import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/filter_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
class FilterCatalogWidget extends StatelessWidget {
  const FilterCatalogWidget({Key? key}) : super(key: key);

void colorFilter({required List chosenColor,required BuildContext context}){
  FilterLogic.selectedColors = chosenColor.cast<String>() ;
  BlocProvider.of<CarCatalogCubit>(context).filterCars();
}

  void acceptedAccessoriesFilter({required List acceptedAccessories,required BuildContext context}){
    FilterLogic.selectedAcceptedAccessories = acceptedAccessories.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();

  }

  void rejectedAccessoriesFilter({required List rejectedAccessories,required BuildContext context}){
    FilterLogic.selectedRejectedAccessories = rejectedAccessories.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  void rejectedRepairsFilter({required List rejectedRepairs,required BuildContext context}){
    FilterLogic.selectedeRejectedRepaires = rejectedRepairs.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  void selectedRepairsCountFilter({required List selectedRepairsCount,required BuildContext context}){
    FilterLogic.selectedRepairesCount = selectedRepairsCount.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }
  void modelFilter({required List selectedModels,required BuildContext context }){
  FilterLogic.selectedeModels=selectedModels.cast<String>();
  BlocProvider.of<CarCatalogCubit>(context).filterCars();

  }



  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 5,
      runSpacing: 5,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: MultiSelectDialogField(
            buttonText: Text('اللون'),
              initialValue: FilterLogic.selectedColors??[],
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

              title: Text('Colors'),
              onSelectionChanged: (List colors){
              colorFilter(chosenColor: colors, context: context);
              },
              items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableColors!),
              onConfirm: (List v){}),
        ),
        FittedBox(
          fit: BoxFit.contain,
          child: MultiSelectDialogField(
              buttonText: Text('الكماليات المطلوبة'),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

              initialValue: FilterLogic.selectedAcceptedAccessories??[],
            searchable: true,
            title: Text('Accepted Accessories'),
              onSelectionChanged: (List accessories){
              acceptedAccessoriesFilter(acceptedAccessories: accessories, context: context);
              },

              items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableAcceptedAccessories!),
              onConfirm: (List v){}),
        ),
        FittedBox(
          fit: BoxFit.contain,
child: MultiSelectDialogField(
    buttonText: Text('الكماليات المرفوضة'),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

    initialValue: FilterLogic.selectedRejectedAccessories??[],

    title: Text('Rejected Accessories'),
    onSelectionChanged: (List accessories){
      rejectedAccessoriesFilter(rejectedAccessories: accessories, context: context);
    },
    items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableRejectedAccessories!),
    onConfirm: (List v){}),
        ),

        FittedBox(
          fit: BoxFit.contain,
          child:         MultiSelectDialogField(
              buttonText: Text('الإصلاحات المرفوضة'),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

              initialValue: FilterLogic.selectedeRejectedRepaires??[],

              title: Text('Rejected Repairs'),
              onSelectionChanged: (List repairs){
                print(repairs);
                rejectedRepairsFilter(rejectedRepairs: repairs, context: context);
              },
              items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableRejectedRepaires!),
              onConfirm: (List v){}),

        ),
        FittedBox(
          fit: BoxFit.contain,
          child:         MultiSelectDialogField(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
              buttonText: Text('عدد الإصلاحات المسموح'),

              initialValue: FilterLogic.selectedRepairesCount??[],

              title: Text('Repairs Count'),
              onSelectionChanged: (List repairsCount){
                selectedRepairsCountFilter(selectedRepairsCount: repairsCount, context: context);
              },
              items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableRepairesCount),
              onConfirm: (List v){}),

        ),
        FittedBox(
          fit: BoxFit.contain,
          child:         MultiSelectDialogField(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
              buttonText: Text('الموديل'),

              initialValue: FilterLogic.selectedeModels??[],

              title: Text('Model'),
              onSelectionChanged: (List models){
                modelFilter(selectedModels: models, context: context);
              },
              items: FilterLogic.toMultiSelect(singleFilterList: FilterLogic.availableModels!),
              onConfirm: (List v){}),

        ),
      ],
    );
  }
}
