import 'package:elgamalstatics/presentation/const_widgets/const_widgets.dart';
import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../data/local/shared_preference_assistant.dart';
import '../logic_code_machine/excel_Management.dart';
import '../resources/routes_manager.dart';



class ChangeNumbersScreen extends StatefulWidget {
  const ChangeNumbersScreen({super.key});

  @override
  _ChangeNumbersScreenState createState() => _ChangeNumbersScreenState();
}

class _ChangeNumbersScreenState extends State<ChangeNumbersScreen> {
  final Map<String, double> numberMap = {};

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    _controller8.dispose();
    super.dispose();
  }


  _submit() async {
    setState(() {
      numberMap['Check Cost'] = double.parse(_controller1.text);
      numberMap['Encar Cost'] = double.parse(_controller2.text);
      numberMap['Shipping Cost'] = double.parse(_controller3.text);
      numberMap['Custom Clearnce Cost'] = double.parse(_controller4.text);
      numberMap['Transfer Commission'] = double.parse(_controller5.text);
      numberMap['Won Price'] = double.parse(_controller6.text);
      numberMap['Dollar Price'] = double.parse(_controller7.text);
      numberMap['Profits'] = double.parse(_controller8.text);
    });
    bool isSaved = await SharedPreferenceAssistant.saveShared(numberMap, AppStrings.calaculatorNumbers);
    await PriceCalculator.fetchNumbers();
  if(isSaved){
    await ExcelManagement.initiateElgamalCars();
    await ExcelManagement.initiateAllCars(onSheetLoadedCallback: (){});
    await ExcelManagement.initiateElgamalCarsId();
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }else{
    ConstWidgets.alertDialog(context: context, content: Text('Plz Enter Correct Value'), title: 'ERROR');
  }
  }

 @override
  void initState() {
   if(PriceCalculator.allNumbers != null){
     _controller1.text=PriceCalculator.checkCost.toString();
     _controller2.text=PriceCalculator.encarCost.toString();
     _controller3.text=PriceCalculator.shippingCost.toString();
     _controller4.text=PriceCalculator.customsClearanceCosts.toString();
     _controller5.text=PriceCalculator.transferCommisssion.toString();
     _controller6.text=PriceCalculator.wonPrice.toString();
     _controller7.text=PriceCalculator.dollarPrice.toString();
     _controller8.text=PriceCalculator.profits.toString();
   }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Calculator Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Check Cost'),
            ),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Encar Cost'),
            ),
            TextField(
              controller: _controller3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Shipping Cost'),
            ),
            TextField(
              controller: _controller4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Custom Clearnce Cost'),
            ),
            TextField(
              controller: _controller5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Transfer Commission'),
            ),
            TextField(
              controller: _controller6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Won Price'),
            ),
            TextField(
              controller: _controller7,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Dollar Price'),
            ),
            TextField(
              controller: _controller8,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Profits'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _submit();
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text('Collected Numbers: $numberMap'),
          ],
        ),
      ),
    );
  }
}
