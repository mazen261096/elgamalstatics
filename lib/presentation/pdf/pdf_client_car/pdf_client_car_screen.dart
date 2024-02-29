import 'package:elgamalstatics/presentation/pdf/pdf_client_car/pdf_client_car_builder.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';


class PdfClientCarScreen extends StatelessWidget {
  const PdfClientCarScreen( {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Client Car Preview'),
      ),
      body: Directionality(textDirection: TextDirection.rtl,
          child: PdfPreview(
            build: (context) async => await PdfClientCarBuilder().makePdf(),
          )),
    );
  }
}

