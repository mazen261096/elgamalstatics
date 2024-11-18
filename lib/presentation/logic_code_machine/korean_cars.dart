import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import '../../models/car.dart';

class KoreanCarsRemote {

/*


static Future<void> getCars ()async {
  QuerySnapshot<Map<String, dynamic>> carsDocs = await FirebaseFirestore.instance.collection('cars').get();
  ExcelManagement.carsLists.clear();
  ExcelManagement.allCars.clear();
  ExcelManagement.names.clear();
  List<Car> newList=[];

  carsDocs.docs.forEach((element) {
    print(element.id);
    print(element.data());


    element.data().forEach((key, value) {
      newList.add(Car.fromFirebase(value));
    });


  });

  ExcelManagement.allCars = newList;


}

 */
}