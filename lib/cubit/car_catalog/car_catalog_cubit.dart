import 'package:bloc/bloc.dart';
import 'package:elgamalstatics/app/app_prefs.dart';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_states.dart';
import 'package:elgamalstatics/data/remote/CarService.dart';
import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/filter_logic.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/sort_logic.dart';
import 'package:excel/excel.dart';


class CarCatalogCubit extends Cubit<CarCatalogStates>{
  CarCatalogCubit():super(CarCatalogIntialState());


late List<Car> allCars ;
late List<Car> cars ;
FilterLogic filter = FilterLogic();

Future<void> updateServer ()async{
await CarService().createCarsBatch(allCars);
emit(CarCatalogGetCarsSuccessState());
}

  Future<void> getCarsServer ()async{
    print(await CarService().getAllCars()) ;
    emit(CarCatalogGetCarsSuccessState());
  }

  Future<void> createCarsServer ()async{
    await CarService().createCarsBatch(allCars);
    emit(CarCatalogGetCarsSuccessState());
  }

  Future<void> filterCars() async{
  emit(CarCatalogGetCarsState());
  cars = await filter.filteredCars(cars: allCars);
  emit(CarCatalogGetCarsSuccessState());
}



Future<void> sort (String sortType) async{
  emit(CarCatalogGetCarsState());
  cars = await SortLogic.sort(cars, sortType);
  emit(CarCatalogGetCarsSuccessState());

}



  Future<void> getCars ({required List<Car> cars})  async {
  print(cars.length);
    emit(CarCatalogGetCarsState());
    try{
    //  await KoreanCarsRemote.getCars();
   //   List<String> paths = await ExcelManagement.openFilePicker();


      this.cars =cars;
      allCars=cars;  // to filter from cause cars will change when filter
      await filter.initiateFilter(cars: allCars);


}catch(error){
      print(error);
      emit(CarCatalogGetCarsFailedState());
      rethrow;
    }
    emit(CarCatalogGetCarsSuccessState());
  }




  Future<void> getElgamalCars ()  async {
    try{

    await  ExcelManagement.initiateElgamalCars();
    await  ExcelManagement.initiateElgamalCarsId();


}catch(error){
      print(error);
      rethrow;
    }
  }

  Future<void> addToElgamal({required Car carItem})async {
    Excel file =      await ExcelManagement.pathToExcelFile(path:'C:/Users/${AppPreferences.windowsUserName}/Documents/CarData/outputs/${carItem.fileName}.xlsx');
    Sheet sheet =     await ExcelManagement.getSheetByNumber(file:file, sheetNumber: 1);
    List<Data?>? row =await ExcelManagement.getRowByColumnValue(sheet: sheet, columnNumber: 0, value: carItem.id.toString());
    await ExcelManagement.addRow(filePath: ExcelManagement.elgamalPath, row: row,carItem: carItem);
    await getElgamalCars();
  }

  Future<void> removeFromElgamal({required Car carItem})async {
    Excel file =      await ExcelManagement.pathToExcelFile(path:ExcelManagement.elgamalPath);
    Sheet sheet =     await ExcelManagement.getSheetByNumber(file:file, sheetNumber: 1);
    int? rowNumber =await ExcelManagement.getRowNumberByColumnValue(sheet: sheet, columnNumber: 0, value: carItem.id.toString());
    await ExcelManagement.removeRow(filePath: ExcelManagement.elgamalPath, rowNumber: rowNumber);
    await getElgamalCars();
    if(cars.length<ExcelManagement.allCars.length){
      cars.remove(carItem);

    }
  }



  Future<void> addOrRemoveElgamalCars ({required Car carItem})  async {
    emit(CarCatalogGetElgamalCarsState());
    try{

      if(ExcelManagement.elgamalCarsId.contains(carItem.id)){
        await removeFromElgamal(carItem: carItem);

      }else{
        await addToElgamal(carItem: carItem);
      }

      emit(CarCatalogGetElgamalCarsSuccessState());

    }catch(error){
      print(error);
      emit(CarCatalogGetElgamalCarsFailedState());
      rethrow;
    }
  }

  Future<void> modifyCarBonus({required Car carItem, required double newPrice}) async {
    try {
      // تعديل السعر داخل ملف Excel
      await ExcelManagement.modifyCarBonus(carItem.id.toString(), newPrice);

      // تحديث حالة Bloc بعد التعديل
      emit(CarBonusModifiedState(carItem: carItem, newPrice: newPrice));
    } catch (e) {
      emit(CarBonusErrorState(e.toString()));
    }
  }

Future<void> modifyElgamalPricing (String filePath, Map<String, String> newValues) async{
  try{
    emit(ElgamalPricingModifyState());
    await ExcelManagement.saveElgamalPricingNumbers(filePath, newValues);
    emit(ElgamalPricingModifiedState());

  }catch(error){
    throw(error);
    emit(ElgamalPricingModifyErrorState());

  }
}

}