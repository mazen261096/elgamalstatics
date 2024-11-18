import 'dart:io';
import 'package:elgamalstatics/app/app_prefs.dart';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_states.dart';
import 'package:elgamalstatics/data/remote/CarService.dart';
import 'package:path/path.dart';
import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:elgamalstatics/models/car.dart';
import 'package:elgamalstatics/presentation/cars_catalog/cars_catalog_screen.dart';
import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:elgamalstatics/presentation/const_widgets/dawnload_photos.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/excel_Management.dart';
import 'package:elgamalstatics/presentation/pdf/pdf_client_car/pdf_client_car_builder.dart';
import 'package:elgamalstatics/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cars_accessories_widget.dart';
import 'package:intl/intl.dart';
import 'gallay_screen.dart';

class CarItem extends StatelessWidget {
  const CarItem({Key? key, required this.carItem}) : super(key: key);
  final Car carItem;

  void _showPriceEditDialog(BuildContext context) {
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('تعديل السعر'),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'أدخل السعر الجديد'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                double newPrice = double.tryParse(priceController.text)! ;

                // استدعاء Bloc لتعديل السعر
               await BlocProvider.of<CarCatalogCubit>(context).modifyCarBonus(
                  carItem: carItem,
                  newPrice: newPrice,
                );

                Navigator.pop(context,true);
              },
              child: Text('حفظ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context,false);
              },
              child: Text('إلغاء'),
            ),
          ],
        );
      },
    ).then(( edited){
      if(edited==true)BlocProvider.of<CarCatalogCubit>(context).getCars(cars: ExcelManagement.elgamalCars);
    });
  }
  void getReport(BuildContext context) {
    PdfClientCarBuilder.car = carItem;
    Navigator.pushNamed(context, Routes.pdfClientCarRoute);
  }

  void _showImageViewerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: ImageViewer(
              imageLinks: carItem.carPhotos,
              initialIndex: 0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ExcelManagement.elgamalCarsId.contains(carItem.id)
          ? Colors.amber
          : Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _showPriceEditDialog(context),
            child: Text('تعديل السعر'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    getReport(context);
                  },
                  icon: const Icon(Icons.picture_as_pdf)),
              DownloadPhotos(
                  imageUrls: carItem.carPhotos,
                  folderName: carItem.id.toString(),
                  directoryPath:
                      'C:/Users/${AppPreferences.windowsUserName}/Documents/CarData/photos')
            ],
          ),
          Text(carItem.review.toString()),
          Text(carItem.enka.toString()),
          Text(carItem.fileName.toString()),
          Text(carItem.insuranceDate.toString()),
          Text('مبلغ التأمين : ${carItem.insuranceCode.toString()}'),
          Text('عدد القطع : ${carItem.repairsCount.toString()}'),
          Text('الإصلاحات : ${carItem.repairs.toString()}'),
          Text('اللون : ${carItem.color.toString()}'),
          Text('العداد : ${(carItem.counter / 1000).round()}'),
          Text(
              'تاريخ الصنع : ${DateFormat('MM/yyyy').format(carItem.actualYear)}'),
          Text('سنة الترخيص : ${carItem.licenseYear.toString()}'),
          Text('المدينة : ${carItem.city.toString()}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    Clipboard.setData(ClipboardData(
                        text: carItem.generateFacebookPostFromCar(carItem)));
                  },
                  icon: Icon(Icons.copy)),
              Text('رقم الهاتف : ${carItem.contactNumber.toString()}'),
            ],
          ),
          Text(
              'السعر بالكورى : ${NumberFormat.decimalPattern().format(carItem.price)}'),
          Text(
              'السعر بالدولار : ${NumberFormat.decimalPattern().format(carItem.totalCostDollar)}'),
          Text(
              'السعر بالمصرى : ${NumberFormat.decimalPattern().format(carItem.totalCostEgp)}'),
          ElevatedButton(
            onPressed: () {
              ConstWidgets.alertDialog(
                  context: context,
                  content: Container(
                    width: double.maxFinite,
                    child: AccessoriesWidget(
                        carItem: carItem), // Your widget goes here
                  ),
                  title: "كـــماليات السيارة");
            },
            child: const Text('عرض الكماليات'),
          ),
          ElevatedButton(
            onPressed: () async {
              _showImageViewerDialog(context);
              print(carItem.carPhotos);
            },
            child: const Text('عرض الصور'),
          ),
          ElevatedButton(
            onPressed: () async {
              await BlocProvider.of<CarCatalogCubit>(context)
                  .addOrRemoveElgamalCars(carItem: carItem)
                  .onError((Object, StackTrace) {
                ConstWidgets.handleError(context, Object.toString());
              });

              //await KoreanCarsRemote.getCars();
              /*


              await  FirebaseFirestore.instance.collection('cars').doc('cars').set(modelToFire(ExcelManagement.allCars)).then((value) {
              print('Done');
            }).onError((error, stackTrace) {
              print(error.toString());
            });
               */
            },
            child: const Text(' الجمل للسيارات  '),
          ),
          ConstWidgets.clickLink(
              link: Uri.parse(carItem.url), name: " عرض بالموقع")
        ],
      ),
    );
  }
}
