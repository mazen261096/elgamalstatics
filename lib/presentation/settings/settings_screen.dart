import 'package:flutter/material.dart';

import '../resources/routes_manager.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
void editeNumbers(BuildContext context){
Navigator.pushNamed(context, Routes.changeNumbersRoute);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            editeNumbers(context);
          }, child: const Text('Change Numbers')),

        ],
      ),

    );
  }
}
