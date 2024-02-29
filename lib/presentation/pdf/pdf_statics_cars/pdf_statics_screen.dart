import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:elgamalstatics/presentation/pdf/pdf_statics_cars/pdf_statics_builder.dart';

class PdfStaticsScreen extends StatelessWidget {
   const PdfStaticsScreen( {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: Directionality(textDirection: TextDirection.rtl,
          child: PdfPreview(
            build: (context) async => PdfStaticsBuilder().makePdf(),
          )),
    );
  }
}

