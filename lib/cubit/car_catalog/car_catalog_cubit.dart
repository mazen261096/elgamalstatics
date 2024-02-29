import 'package:bloc/bloc.dart';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_states.dart';
import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/filter_logic.dart';

class CarCatalogCubit extends Cubit<CarCatalogStates>{
  CarCatalogCubit():super(CarCatalogIntialState());


late List<Car> cars ;


  Future<void> filterCars() async{
  emit(CarCatalogGetCarsState());
  cars = await FilterLogic.filteredCars(cars: ExcelManagement.allCars);
  emit(CarCatalogGetCarsSuccessState());
}



  Future<void> getCars ()  async {
    emit(CarCatalogGetCarsState());
    try{
      await ExcelManagement.importMultiSheet();
      cars = ExcelManagement.allCars;
      await FilterLogic.initiateFilter(cars: cars);
}catch(error){
      emit(CarCatalogGetCarsFailedState());
      rethrow;
    }
    emit(CarCatalogGetCarsSuccessState());
  }


}