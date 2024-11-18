import 'dart:io';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_states.dart';
import 'package:flutter/material.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElgamalPricingScreen extends StatefulWidget {
  @override
  _ElgamalPricingScreenState createState() => _ElgamalPricingScreenState();
}

class _ElgamalPricingScreenState extends State<ElgamalPricingScreen> {
  // أسماء الحقول المطلوبة
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

  // استخدام Map لتخزين controllers
  Map<String, TextEditingController> controllers = {};

  String excelFilePath = ExcelManagement.elgamalPath; // هنا تضع مسار ملف Excel

  @override
  void initState() {
    super.initState();
    // إنشاء TextEditingController لكل حقل
    for (var field in fields) {
      controllers[field] = TextEditingController();
    }
    loadExcelData();
  }

  Future<void> loadExcelData() async {
    try {
      // استدعاء دالة القراءة من ExcelManagement
      Map<String, dynamic> excelData = await ExcelManagement.loadElgamalPricingNumbers(excelFilePath);

      // قراءة القيم وتخزينها في controllers
      for (var field in fields) {
        controllers[field]?.text = excelData[field]?.toString() ?? "";
      }
    } catch (e) {
      print("Error loading Excel: $e");
    }
  }

  Future<void> saveExcelData() async {
    try {
      // تجميع القيم الجديدة في خريطة Map
      Map<String, String> newValues = {};
      for (var field in fields) {
        newValues[field] = controllers[field]?.text ?? "";
      }

      // استدعاء دالة الحفظ من ExcelManagement
BlocProvider.of<CarCatalogCubit>(context).modifyElgamalPricing(excelFilePath, newValues);
      // إظهار رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حفظ التغييرات بنجاح!")));
      Navigator.pop(context);
    } catch (e) {
      print("Error saving Excel: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // للحصول على حجم الشاشة
    var screenSize = MediaQuery.of(context).size;

    return BlocProvider<CarCatalogCubit>(create: (BuildContext context)=>CarCatalogCubit(),
    child: BlocConsumer<CarCatalogCubit,CarCatalogStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('تعديل القيم'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: state==ElgamalPricingModifyState?
              Center(
                child: CircularProgressIndicator(),
              )
                  :
              Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: screenSize.width > 600 ? 2 : 1,  // عرض حقول في عمودين في الشاشات الأكبر
                        crossAxisSpacing: 20,  // المسافات الأفقية بين الحقول
                        mainAxisSpacing: 20,  // المسافات العمودية بين الحقول
                        childAspectRatio: screenSize.width > 600 ? 5:5,  // نسبة العرض إلى الارتفاع للحقل
                      ),
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        var field = fields[index];
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(

                            controller: controllers[field],
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 20,  // حجم النص داخل الحقل
                              color: Colors.black87,  // لون النص داخل الحقل
                              fontWeight: FontWeight.w500,  // وزن الخط
                            ),
                            decoration: InputDecoration(
                              labelText: field,  // اسم الحقل
                              labelStyle: TextStyle(
                                fontSize: 18,  // حجم النص لاسم الحقل (Label)
                                fontWeight: FontWeight.bold,  // وزن الخط لاسم الحقل
                                color: Colors.blueGrey,  // لون النص لاسم الحقل
                              ),
                              filled: true,  // تعبئة الخلفية
                              fillColor: Colors.grey[100],  // لون الخلفية
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),  // المسافات داخل الحقل
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),  // الزوايا الدائرية للحواف
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,  // لون الحواف في الوضع العادي
                                  width: 2,  // عرض الحواف
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),  // الزوايا الدائرية للحواف عند التركيز
                                borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent,  // لون الحواف عند التركيز
                                  width: 3,  // عرض الحواف عند التركيز
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 3,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.money,  // الأيقونة التي تظهر داخل الحقل (يمكنك تغيير الأيقونة حسب الحقل)
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: ()async{
                      try {
                        // تجميع القيم الجديدة في خريطة Map
                        Map<String, String> newValues = {};
                        for (var field in fields) {
                          newValues[field] = controllers[field]?.text ?? "";
                        }

                        // استدعاء دالة الحفظ من ExcelManagement
                        await BlocProvider.of<CarCatalogCubit>(context).modifyElgamalPricing(excelFilePath, newValues);
                        // إظهار رسالة نجاح
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حفظ التغييرات بنجاح!")));
                        Navigator.pop(context);
                      } catch (e) {

                        print("Error saving Excel: $e");
                      }
                    },
                    child: Text('حفظ'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),  // حجم الزر
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  // حجم ونمط النص
                    ),
                  ),
                ],
              )
              ,
            ),
          );
        }),
    );
  }
}
