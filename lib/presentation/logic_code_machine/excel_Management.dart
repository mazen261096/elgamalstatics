import 'dart:io';
import 'package:elgamalstatics/app/app_prefs.dart';
import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';

import '../../data/remote/CarService.dart';

class ExcelManagement {


static List<String> allPaths =  Directory('C:/Users/${AppPreferences.windowsUserName}/Documents/CarData/outputs/').listSync().map((e) => e.path).toList();
static String elgamalPath = 'C:/Users/${AppPreferences.windowsUserName}/Documents/CarData/outputs/elgamal.xlsx';
static late List<Car> elgamalCars ;
static late List<Car> allCars ;
static late List<int> elgamalCarsId;
static int sheetsLoaded = 0 ;
static int s=0 ;


static Future<List<Car>> importMultiSheetCars ({required List<String> paths,required VoidCallback onSheetLoadedCallback}) async{
    List<Car> allCars=[] ;

List<Car> newList;
  try {
    sheetsLoaded = 0 ;
    for (var path in paths) {
      s++;
      print('ssssssssssssssssssssssssssssssss$s');
      if(path != elgamalPath){
        print('ssssssssssssssssssssssssssssssss$s');
        newList = await importSingleSheetCars(path);
        print('ssssssssssssssssssssssssssssssss$s');
        print(newList.length);

        allCars.addAll(newList);
        sheetsLoaded++;
        onSheetLoadedCallback();
      }

    }
    allCars.toSet().toList();
return allCars ;
  }catch(error){
    rethrow;

  }


}


static Future<List<Car>> importSingleSheetCars(String pathName) async {
  // جمع القيم المحسوبة من PriceCalculator
  Map<String, double> calculatorData = {
    'checkCost': PriceCalculator.checkCost,
    'encarCost': PriceCalculator.encarCost,
    'shippingCost': PriceCalculator.shippingCost,
    'customsClearanceCosts': PriceCalculator.customsClearanceCosts,
    'transferCommisssion': PriceCalculator.transferCommisssion,
    'wonPrice': PriceCalculator.wonPrice,
    'dollarPrice': PriceCalculator.dollarPrice,
    'profits': PriceCalculator.profits,
  };
  print('ggggggggggggggggggggggggggggggggggggggggg');

  // تمرير القيم إلى isolate
  return await compute(_importSingleSheetCars, {'pathName': pathName, 'calculatorData': calculatorData});
}
static List<Car> _importSingleSheetCars(Map<String, dynamic> params) {
print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
  String pathName = params['pathName'];
  Map<String, double> calculatorData = params['calculatorData'];

  // تهيئة PriceCalculator داخل isolate بالقيم الممررة
  PriceCalculator.checkCost = calculatorData['checkCost']!;
  PriceCalculator.encarCost = calculatorData['encarCost']!;
  PriceCalculator.shippingCost = calculatorData['shippingCost']!;
  PriceCalculator.customsClearanceCosts = calculatorData['customsClearanceCosts']!;
  PriceCalculator.transferCommisssion = calculatorData['transferCommisssion']!;
  PriceCalculator.wonPrice = calculatorData['wonPrice']!;
  PriceCalculator.dollarPrice = calculatorData['dollarPrice']!;
  PriceCalculator.profits = calculatorData['profits']!;

  List<Car> cars = [];
  try {
    Excel excel = pathToExcelFile(path: pathName);
    Sheet firstSheet = getSheetByNumber(file: excel, sheetNumber: 1);

    for (int i = 0; i < firstSheet.rows.length; i++) {
      if (i != 0 && firstSheet.rows[i][29]?.value.toString().toLowerCase().trim() == 'true') {
        if (firstSheet.rows[i][0] != null) {
          // استدعاء الدالة Car.fromRow بعد تجهيز PriceCalculator
          cars.add(Car.fromRow(firstSheet.rows[i], fileName(path: pathName)));
        }
      }
    }
  } catch (error) {
    rethrow; // يمكنك تحسين ذلك بإضافة معالجة الأخطاء
  }

  return cars;
}
  static String fileName({required String path}){
    String basename = p.basename(path).split('.').first;
    return basename ;
  }
  static List<String> multiFileNames ({required List<String> paths}){
  List<String> names = [];
  for(var path in paths){
    names.add(fileName(path: path));
  }
  return names;
  }
 static Future <List<String>> openFilePicker() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        lockParentWindow: true,
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'], // Allow only Excel files
        allowMultiple: true,
      );
      if (result != null) {
        List<String> newPaths = result.files.map((e) => e.path!).toList();
         return newPaths;
      }else{
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
  static Excel pathToExcelFile({required String path}){
   var bytes = File(path).readAsBytesSync();
   return Excel.decodeBytes(bytes);
 }
 static Sheet getSheetByNumber({required Excel file,required int sheetNumber}){
   List<String> sheetsNames= file.tables.keys.toList();
   return file.tables[sheetsNames[sheetNumber-1]]!;
 }
 static int getNewRowNumber ({required Sheet sheet}){
   return sheet.maxRows+1;
 }
 static Future<List<Data?>?> getRowByColumnValue ({required Sheet sheet , required int columnNumber ,required String value })async{
   for(int i = 0; i<sheet.rows.length ;i++){
     var row = sheet.rows[i];

     if(row[columnNumber]?.value.toString()==value){

       return row;
     }
   }

   return null;
 }
static Future<int?> getRowNumberByColumnValue ({required Sheet sheet , required int columnNumber ,required String value })async{
  for(int i = 0; i<sheet.rows.length ;i++){
    var row = sheet.rows[i];

    if(row[columnNumber]?.value.toString()==value){

      return i;
    }
  }

  return null;
}


static Future<void> addRow({required String filePath, required List<Data?>? row, required Car carItem}) async {
  Excel file1 = await ExcelManagement.pathToExcelFile(path: filePath);
  Sheet sheet1 = await ExcelManagement.getSheetByNumber(file: file1, sheetNumber: 1);
print(await readElgamalPricing());
  List<TextCellValue> newRowValues = row!.map((e) => TextCellValue(e == null ? '' : e.value.toString())).toList();

  newRowValues.addAll([
    TextCellValue(carItem.company),
    TextCellValue(carItem.brand),
    TextCellValue(carItem.model),
    TextCellValue(carItem.luxuryCategory),
    TextCellValue('0'),
    TextCellValue('0'),
    TextCellValue('0'),
    TextCellValue((carItem.licenseYear.toString()),

    )]);

  file1.appendRow(sheet1.sheetName, newRowValues.cast<CellValue>());
  print('looooooooooooooooooooooooooooooooooooooooooool');
print('sssssssssssssssssaaaaaaaaaaaaaaa');
  var newbytes = file1.save();
  File(join(filePath))
    ..createSync(recursive: true)
    ..writeAsBytesSync(newbytes!);
}


static Future<void> removeRow ({required String filePath, required int? rowNumber}) async{

  Excel file1  =      await ExcelManagement.pathToExcelFile(path:filePath);
  Sheet sheet1 =     await ExcelManagement.getSheetByNumber(file:file1, sheetNumber: 1);
  file1.removeRow(sheet1.sheetName, rowNumber!);
  var newbytes = file1.save();
  File(join(filePath))..createSync(recursive: true)..writeAsBytesSync(newbytes!);

}
static Future<void> initiateElgamalCars() async {
  elgamalCars = await importSingleSheetCars( elgamalPath);
}
static Future<void> initiateAllCars( {required VoidCallback onSheetLoadedCallback}) async {
 // allCars = await CarService().getAllCars();
 allCars = await importMultiSheetCars(paths: allPaths,onSheetLoadedCallback: onSheetLoadedCallback );
}
static Future<void> initiateElgamalCarsId() async {
  elgamalCarsId = await elgamalCars.map((e) => e.id).toList();
}



static Future<Map> readElgamalPricing( ) async {
  // خريطة لتخزين الأسعار
  Map elgamalPricing = {};

  // فتح الملف
  var file = File(elgamalPath);
  var bytes = file.readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  // الوصول إلى الشيت الأول (أو أي شيت تريده)
  var sheet = excel.tables[excel.tables.keys.first];

  // قراءة القيم من الصف الأول (الصف 0 في البرمجة)
  if (sheet != null) {
    elgamalPricing['siteComission'] = sheet.cell(CellIndex.indexByString('AR1')).value ;
    elgamalPricing['checkComission'] = sheet.cell(CellIndex.indexByString('AS1')).value ;
    elgamalPricing['ransactionComission'] = sheet.cell(CellIndex.indexByString('AT1')).value ;
    elgamalPricing['transportPrice'] = sheet.cell(CellIndex.indexByString('AU1')).value ;
    elgamalPricing['gomrok'] = sheet.cell(CellIndex.indexByString('AV1')).value ;
    elgamalPricing['elgamalComission'] = sheet.cell(CellIndex.indexByString('AW1')).value ;
    elgamalPricing['wonPrice'] = sheet.cell(CellIndex.indexByString('AX1')).value ;
    elgamalPricing['dollarPrice'] = sheet.cell(CellIndex.indexByString('AY1')).value ;
  }

  return elgamalPricing;
}

static Future<void> repriceElgamalCars() async {
  // فتح الملف

  var bytes = File(elgamalPath).readAsBytesSync();

  Excel excel = Excel.decodeBytes(bytes);
  Sheet sheet = await ExcelManagement.getSheetByNumber(file: excel, sheetNumber: 1);
  print('q');

  // الوصول إلى الشيت الأول (أو أي شيت تريده)

  // التأكد من وجود الشيت
  if (sheet != null) {

    // المرور على الصفوف ابتداءً من الصف الثاني (الصف 1)
    for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
      // قراءة القيم من العمودين N و AQ

      double price = double.parse(sheet.cell(CellIndex.indexByString('N${rowIndex + 1}')).value.toString());

      double bonusDollar = double.parse(sheet.cell(CellIndex.indexByString('AQ${rowIndex + 1}')).value.toString());

      Map elgamalPricing = await readElgamalPricing();

      int siteComission = int.parse(elgamalPricing['siteComission'].toString());

      int checkComission = int.parse(elgamalPricing['checkComission'].toString());
      double transactionComission = double.parse(elgamalPricing['ransactionComission'].toString());

      int transportPrice = int.parse(elgamalPricing['transportPrice'].toString());

      int gomrok = int.parse(elgamalPricing['gomrok'].toString());

      int elgamalComission = int.parse(elgamalPricing['elgamalComission'].toString());

      int wonPrice = int.parse(elgamalPricing['wonPrice'].toString());

      double dollarPrice = double.parse(elgamalPricing['dollarPrice'].toString());

      // حساب القيم
      double totalPaidInWonByDollar = ((price + siteComission + checkComission) * 1000) / wonPrice;
      double totalCostDollar = totalPaidInWonByDollar + (totalPaidInWonByDollar * transactionComission) + transportPrice + gomrok + elgamalComission + bonusDollar;
      double totalCostEgp = totalCostDollar * dollarPrice;

      // تعديل القيم في العمودين AO و AP باستخدام TextCellValue لتحويل القيم إلى نص
      excel.tables.values.toList()[0].cell(CellIndex.indexByString('AO${rowIndex + 1}')).value = TextCellValue(((totalCostDollar / 10).round() * 10).toString()) ;
      excel.tables.values.toList()[0].cell(CellIndex.indexByString('AP${rowIndex + 1}')).value = TextCellValue(((totalCostEgp / 10).round() * 10).toString()) ;  // تعديل AP بناءً على AQ
    }
    // حفظ الملف بعد التعديل
    var newbytes = excel.save();

    File file = File(elgamalPath);

    // كتابة البيانات الجديدة (newbytes) في الملف
     file.writeAsBytesSync(newbytes!);

    await initiateElgamalCars();

    print('تم حفظ الملف بنجاح!');
  } else {
    print('لم يتم العثور على الشيت.');
  }
}


// دالة لقراءة البيانات من ملف Excel
  static Future<Map<String, dynamic>> loadElgamalPricingNumbers(String filePath) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // افتراض أن الشيت الذي نعمل عليه هو الشيت الأول
    var sheet = excel.tables[excel.tables.keys.first]!;

    // الأعمدة المراد قراءتها
    List<String> columns = ['AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY'];
    List<String> fields = [
      'siteComission',
      'checkComission',
      'transferComission',
      'transportPrice',
      'gomrok',
      'elgamalComission',
      'wonPrice',
      'dollarPrice'
    ];

    // إنشاء خريطة لربط أسماء الحقول بالقيم
    Map<String, dynamic> data = {};

    for (int i = 0; i < columns.length; i++) {
      var value = sheet.cell(CellIndex.indexByString('${columns[i]}1')).value;
      data[fields[i]] = value;
    }

    return data;
  }

  // دالة لحفظ البيانات إلى ملف Excel
  static Future<void> saveElgamalPricingNumbers(String filePath, Map<String, String> newValues) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // تعديل القيم في الأعمدة AR إلى AY في الصف الأول
    var sheet = excel.tables[excel.tables.keys.first]!;
    List<String> columns = ['AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY'];
    List<String> fields = [
      'siteComission',
      'checkComission',
      'transferComission',
      'transportPrice',
      'gomrok',
      'elgamalComission',
      'wonPrice',
      'dollarPrice'
    ];

    for (int i = 0; i < columns.length; i++) {
      sheet.updateCell(CellIndex.indexByString('${columns[i]}1'),TextCellValue(newValues[fields[i]]!) );
    }

    // حفظ الملف المعدل
    var newBytes = excel.encode();
    file.writeAsBytesSync(newBytes!);
    await repriceElgamalCars();
  }

  static Future<void> modifyCarBonus(String carId, double newPrice) async {
    var file = File(elgamalPath); // مسار ملف Excel
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // تعديل السعر داخل Excel بناءً على معرف السيارة (carId)
    var sheet = excel.tables[excel.tables.keys.first]!;
    int s =0;
    for (var row in sheet.rows) {
      print (row[0]?.value) ;
      if (row[0]?.value.toString() == carId) {
        print('founded');
        excel.tables[excel.tables.keys.first]!.rows[s][42]!.value = TextCellValue(newPrice.toString());  // تعديل السعر في العمود المناسب
        break;
      }
      s++;
    }
    var newBytes = excel.encode();
    file.writeAsBytesSync(newBytes!);// حفظ التعديل

    await repriceElgamalCars();

  }

}