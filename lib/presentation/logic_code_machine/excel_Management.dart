import 'dart:io';
import 'package:elgamalstatics/models/car.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class ExcelManagement {

  static late List<String> paths ;

  static  List<List<Car>> carsLists=[] ;
  static  List<Car> allCars=[] ;
  static  List<String> names =[];



 static Future<void> importMultiSheet () async{
carsLists.clear();
allCars.clear();
names.clear();
List<Car> newList;
  try {
    for (var path in paths) {
      newList = await importSingleSheet(path);
      carsLists.add(newList);
      allCars.addAll(newList);
    }
    names = multiFileNames();

  }catch(error){
    rethrow;

  }


}


   static Future<List<Car>> importSingleSheet(String pathName) async {
try{
  List<Car> cars = [];

  var bytes = File(pathName).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {

    for (var row in excel.tables[table]!.rows) {
      cars.add(Car.fromRow(row ,fileName(pathName)));

    }

  }

  return cars ;
}catch(error){
  rethrow;
}


  }

  static String fileName(String path){
    String basename = p.basename(path).split('.').first;
    return basename ;
  }

  static List<String> multiFileNames (){
  List<String> names = [];
  for(var path in paths){
    names.add(fileName(path));
  }
  return names;
  }


 static Future <bool> openFilePicker() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        lockParentWindow: true,
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'], // Allow only Excel files
        allowMultiple: true,
      );
      if (result != null) {
        List<String> newPaths = result.files.map((e) => e.path!).toList();
          paths = newPaths;
          return true;
      }else{
        return false;
      }
    } catch (e) {
      print("Error while picking the file: $e");
      rethrow;
    }
  }





}