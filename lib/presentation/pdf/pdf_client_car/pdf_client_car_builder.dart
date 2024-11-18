

import 'dart:typed_data';
import 'package:elgamalstatics/presentation/resources/assets_manager.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as l;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' ;
import '../../../models/car.dart';



class PdfClientCarBuilder{
   final pdf = Document();
  static late Car car ;

   List<String> existAccessNames() {
     List<String> keys = [];
     car.singleAccessories.forEach((key, value) {
       if (value) {
         keys.add(key);
       }
     });
     return keys;
   }

   Future<Uint8List> makePdf()  async {
    await addPage();

    return pdf.save();

  }



  Future<void> addPage() async {
     print(car.repairs);
    final theme = ThemeData.withFont(
        base: Font.ttf(
          await rootBundle.load('assets/fonts/Tajawal-Regular.ttf',),

        ),
        bold: Font.ttf(
          await rootBundle.load('assets/fonts/Tajawal-Bold.ttf'),
        ));

    final logoImage = MemoryImage(
      (await rootBundle.load(ImageAssets.logo)).buffer.asUint8List(),
    );
    pdf.addPage(Page(
        pageTheme: PageTheme(
          margin: EdgeInsets.all(8),

          textDirection: TextDirection.rtl,
          theme: theme,
          pageFormat: PdfPageFormat.a4,

        ),
        build: (context)  {
          return   Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: PdfColors.blue900,
                  style: BorderStyle.dotted,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              margin: EdgeInsets.all( 0),
              padding: EdgeInsets.only(left: 40,top: 0,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Text('المعلومات الاساسية :-  ',style: TextStyle(color: PdfColors.amber900,fontWeight: FontWeight.bold,fontSize: 18)),
                                SizedBox(height: 20),

                                Text('* موديل السيارة :   ${car.fileName}   ',style: TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14)),
                                SizedBox(height: 10),
                                Text('* الــــــــــســـــــــنــــــــــة  :   ${car.actualYear.year}   ',style: TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14)),
                                SizedBox(height: 10),
                                Text('* الــــــــــــــــلــــــــــــــــــون :    ${car.color} ',style: TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14)),
                                SizedBox(height: 10),

                                Text('* الــــــــــــــعــــــــــــــداد  :   ${l.NumberFormat('#,###').format(car.counter)} كم',style: TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14)),

                              ]
                          ),

                          Image(logoImage, width: 130, height: 130,),

                        ]),//row logo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الــكــماليات :-  ',style: TextStyle(color: PdfColors.amber900,fontWeight: FontWeight.bold,fontSize: 18)),
                        SizedBox(height: 20),

                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          children: existAccessNames()
                              .map((e) => FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: PdfColors.blueGrey50,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                          color: PdfColors.blue900,fontSize: 14

                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ))
                              .toList(),
                        ),

                      ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('الملاحظات :',style: TextStyle(color: PdfColors.amber900,fontWeight: FontWeight.bold,fontSize: 18)),
                        SizedBox(height: 20),
                        car.repairsCount == 0 ?
                        Bullet(
                          text: 'لا يوجد أى ملاحظات السيارة فبريكا بالكامل .',
                          style:  TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14),bulletColor: PdfColors.blue900,
                          textAlign: TextAlign.right,
                        )
                        :
                          Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          children: car.repairs
                              .map((e) => FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: PdfColors.blueGrey50,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: PdfColors.blue900,fontSize: 14

                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ))
                              .toList(),
                        )


                      ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Bullet(
                            text: 'السعر شامل الشحن و الإستخلاص الجمركى .',
                            style:  TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14),bulletColor: PdfColors.blue900,
                            textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 15),
                        Bullet(
                            text: 'الإستلام خارج الميناء .',
                            style:  TextStyle(color: PdfColors.blue900,fontWeight: FontWeight.bold,fontSize: 14),bulletColor: PdfColors.blue900,
                            textAlign: TextAlign.right
                        ),
                      ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text('${l.NumberFormat('#,###').format(car.totalCostDollar)} \$ ',style: TextStyle(color: PdfColors.amber900,fontWeight: FontWeight.bold,fontSize: 25))])

                  ]
              )
          ) ;

        }
    ));

  }




}