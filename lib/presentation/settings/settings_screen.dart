import 'package:elgamalstatics/cubit/car_catalog/car_catalog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/routes_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  void editeNumbers(BuildContext context) {
    Navigator.pushNamed(context, Routes.changeNumbersRoute);
  }
  void editeElgamalNumbers(BuildContext context) {
    Navigator.pushNamed(context, Routes.changeElgamalNumbersRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                editeNumbers(context);
              },
              child: const Text('Change Numbers')),
          ElevatedButton(
              onPressed: () {
                editeElgamalNumbers(context);
              },
              child: const Text('Change Elgamal Numbers')),
        ],
      ),
    );
  }
}
