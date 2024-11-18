import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../models/car.dart';


class FilterCatalogWidget extends StatefulWidget {

    FilterCatalogWidget({Key? key}) : super(key: key);


   @override
  State<FilterCatalogWidget> createState() => _FilterCatalogWidgetState();
}



class _FilterCatalogWidgetState extends State<FilterCatalogWidget> {


  final TextEditingController priceUsdFrom= TextEditingController();

  final TextEditingController priceUsdTo= TextEditingController();

  final TextEditingController priceEgpFrom= TextEditingController();

  final TextEditingController priceEgpTo= TextEditingController();

  final TextEditingController yearFrom= TextEditingController();

  final TextEditingController yearTo= TextEditingController();

  final TextEditingController counterFrom= TextEditingController();

  final TextEditingController counterTo= TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> filterCompany({required List selectedCompany,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedCompany = selectedCompany.cast<String>() ;
    await BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  Future<void> filterBrand({required List selectedBrand,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedBrand = selectedBrand.cast<String>() ;
    await BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  Future<void> filterModel({required List selectedModel,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedModel = selectedModel.cast<String>() ;
    await BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  Future<void> filterLuxuryCategory({required List selectedLuxuryCategory,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedLuxuryCategory = selectedLuxuryCategory.cast<String>() ;
    await BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }


Future<void> colorFilter({required List chosenColor,required BuildContext context}) async {
  BlocProvider.of<CarCatalogCubit>(context).filter.selectedColors = chosenColor.cast<String>() ;
  await BlocProvider.of<CarCatalogCubit>(context).filterCars();
}



  Future<void> acceptedAccessoriesFilter({required List acceptedAccessories,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedAcceptedAccessories = acceptedAccessories.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  Future<void> rejectedAccessoriesFilter({required List rejectedAccessories,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedRejectedAccessories = rejectedAccessories.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
}

  Future<void> rejectedRepairsFilter({required List rejectedRepairs,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedRejectedRepairs = rejectedRepairs.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
  }

  Future<void> selectedRepairsCountFilter({required List selectedRepairsCount,required BuildContext context}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedRepairsCount = selectedRepairsCount.cast<String>() ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> modelFilter({required List selectedModels,required BuildContext context }) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedModels= selectedModels.cast<String>();
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }

  Future<void> cityFilter({required List selectedCity,required BuildContext context }) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedCity=selectedCity.cast<String>();
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }

  Future<void> numberFilter({required List selectedNumbers,required BuildContext context }) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedNumbers=selectedNumbers.cast<String>();
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> priceUsdFromFilter ({required BuildContext context}) async {
    priceUsdFrom.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceDollarFrom=int.parse(priceUsdFrom.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceDollarFrom=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();}


   Future<void> priceUsdToFilter ({required BuildContext context}) async {
     priceUsdTo.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceDollarTo=int.parse(priceUsdTo.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceDollarTo=null;
     BlocProvider.of<CarCatalogCubit>(context).filterCars();   }


  Future<void> priceEgpFromFilter ({required BuildContext context}) async {
    priceEgpFrom.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceEgpFrom=int.parse(priceEgpFrom.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceEgpFrom=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> priceEgpToFilter ({required BuildContext context}) async {
    priceEgpTo.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceEgpTo=int.parse(priceEgpTo.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedPriceEgpTo=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> yearFromFilter ({required BuildContext context}) async {
    yearFrom.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedYearFrom=int.parse(yearFrom.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedYearFrom=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> yearToFilter ({required BuildContext context}) async {
    yearTo.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedYearTo=int.parse(yearTo.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedYearTo=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> counterFromFilter ({required BuildContext context}) async {
    counterFrom.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedCounterFrom=int.parse(counterFrom.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedCounterFrom=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  Future<void> counterToFilter ({required BuildContext context}) async {
    counterTo.text.isNotEmpty? BlocProvider.of<CarCatalogCubit>(context).filter.selectedCounterTo=int.parse(counterTo.text):BlocProvider.of<CarCatalogCubit>(context).filter.selectedCounterTo=null;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();
}

  Future<void> reviewFilter ({required BuildContext context,required bool val}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedReview = val ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }

  Future<void> enkaFilter ({required BuildContext context,required bool val}) async {
    BlocProvider.of<CarCatalogCubit>(context).filter.selectedEnka = val ;
    BlocProvider.of<CarCatalogCubit>(context).filterCars();  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 5,
          runSpacing: 5,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ConstWidgets.customCheckBox(
                    title: 'الغاء الريفيو',
                    checkBox:Checkbox(
                  value: BlocProvider.of<CarCatalogCubit>(context).filter.selectedReview,
                  onChanged: (value){reviewFilter(context: context, val: value! );},
                )
                ),
                ConstWidgets.customCheckBox(
                    title: 'إظهر إنكا فقط',
                    checkBox: Checkbox(
                    value: BlocProvider.of<CarCatalogCubit>(context).filter.selectedEnka,
                    onChanged: (value){enkaFilter(context: context, val: value!);}

                )),
              ],
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  listType: MultiSelectListType.CHIP,
                  buttonText: const Text('الشركة'),
                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedCompany??[],
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  title: const Text('الشركة'),
                  onSelectionChanged: (List selectedCompany) async {
                    await filterCompany(selectedCompany: selectedCompany, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableCompany!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  listType: MultiSelectListType.CHIP,
                  buttonText: const Text('الماركة'),
                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedBrand??[],
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  title: const Text('الماركة'),
                  onSelectionChanged: (List selectedBrand) async {
                    await filterBrand(selectedBrand: selectedBrand, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableBrand!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  listType: MultiSelectListType.CHIP,
                  buttonText: const Text('الموديل'),
                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedModel??[],
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  title: const Text('الموديل'),
                  onSelectionChanged: (List selectedModel) async {
                    await filterModel(selectedModel: selectedModel, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableModel!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  listType: MultiSelectListType.CHIP,
                  buttonText: const Text('الـفـئـة'),
                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedModel??[],
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  title: const Text('الـفـئـة'),
                  onSelectionChanged: (List selectedLuxuryCategory) async {
                    await filterLuxuryCategory(selectedLuxuryCategory: selectedLuxuryCategory, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableLuxuryCategory!),
                  onConfirm: (List v){}),
            ),

            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  listType: MultiSelectListType.CHIP,
                buttonText: const Text('اللون'),
                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedColors??[],
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  title: const Text('Colors'),
                  onSelectionChanged: (List colors) async {
                    print(colors);
                  await colorFilter(chosenColor: colors, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableColors!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: MultiSelectDialogField(
                  separateSelectedItems: true,

                  buttonText: const Text('الكماليات المطلوبة'),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedAcceptedAccessories??[],
                searchable: true,
                title: const Text('Accepted Accessories'),
                  onSelectionChanged: (List accessories) async {
                  await acceptedAccessoriesFilter(acceptedAccessories: accessories, context: context);
                  },

                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableAcceptedAccessories!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
        child: MultiSelectDialogField(
            separateSelectedItems: true,

            buttonText: const Text('الكماليات المرفوضة'),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

        initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedRejectedAccessories??[],

        title: const Text('Rejected Accessories'),
        onSelectionChanged: (List accessories){
          rejectedAccessoriesFilter(rejectedAccessories: accessories, context: context);
        },
        items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableRejectedAccessories!),
        onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child:         MultiSelectDialogField(

                  separateSelectedItems: true,

                  buttonText: const Text('الإصلاحات المرفوضة'),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedRejectedRepairs??[],

                  title: const Text('Rejected Repairs'),
                  onSelectionChanged: (List repairs){
                    print(repairs);
                    rejectedRepairsFilter(rejectedRepairs: repairs, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableRejectedRepairs!),
                  onConfirm: (List v){}),

            ),
            FittedBox(
              fit: BoxFit.contain,
              child:         MultiSelectDialogField(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
                  buttonText: const Text('عدد الإصلاحات المسموح'),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedRepairsCount??[],

                  title: const Text('Repairs Count'),
                  onSelectionChanged: (List repairsCount){
                    selectedRepairsCountFilter(selectedRepairsCount: repairsCount, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableRepairsCount),
                  onConfirm: (List v){}),

            ),
            FittedBox(

              fit: BoxFit.contain,
              child:         MultiSelectDialogField(

                  separateSelectedItems: true,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
                  buttonText: const Text('الموديل'),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedModels??[],

                  title: const Text('Model'),
                  onSelectionChanged: (List models){
                    modelFilter(selectedModels: models, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableModels!),
                  onConfirm: (List v){}),
            ),

            FittedBox(
              fit: BoxFit.contain,
              child:         MultiSelectDialogField(
                  separateSelectedItems: true,

                  searchable: true,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
                  buttonText: const Text('المدينة'),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedCity??[],

                  title: const Text('City'),
                  onSelectionChanged: (List city){
                    cityFilter(selectedCity: city, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableCity!),
                  onConfirm: (List v){}),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child:         MultiSelectDialogField(
                separateSelectedItems: true,
                searchable: true,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber.shade200),
                  buttonText: const Text('رقم المعرض'),

                  initialValue: BlocProvider.of<CarCatalogCubit>(context).filter.selectedNumbers??[],

                  title: const Text('رقم المعرض'),
                  onSelectionChanged: (List shopNumbers){
                    numberFilter(selectedNumbers: shopNumbers, context: context);
                  },
                  items: BlocProvider.of<CarCatalogCubit>(context).filter.toMultiSelect(singleFilterList: BlocProvider.of<CarCatalogCubit>(context).filter.availableNumbers!),
                  onConfirm: (List v){}),
            ),







          ],
        ),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 25,
          runSpacing: 5,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: priceUsdFrom,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Usd From',
                    ),

                    onChanged: (String n){
                      priceUsdFromFilter( context: context);
                    },

                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: priceUsdTo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Usd To',
                    ),

                    onChanged: (String n){
                      priceUsdToFilter( context: context);
                    },

                  ),
                ),

              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: priceEgpFrom,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Egp From',
                    ),

                    onChanged: (String n){
                      priceEgpFromFilter( context: context);
                    },

                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: priceEgpTo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Egp To',
                    ),

                    onChanged: (String n){
                      priceEgpToFilter( context: context);
                    },

                  ),
                ),

              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: yearFrom,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'year From',
                    ),

                    onChanged: (String n){
                      yearFromFilter( context: context);
                    },

                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: yearTo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Year To',
                    ),

                    onChanged: (String n){
                      yearToFilter( context: context);
                    },

                  ),
                ),

              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: counterFrom,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Counter From',
                    ),

                    onChanged: (String n){
                      counterFromFilter( context: context);
                    },

                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    controller: counterTo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Counter To',
                    ),

                    onChanged: (String n){
                      counterToFilter( context: context);
                    },

                  ),
                ),

              ],
            ),
          ],
        ),


      ],
    );
  }
}
