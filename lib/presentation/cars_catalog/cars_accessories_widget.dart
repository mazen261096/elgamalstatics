import 'package:elgamalstatics/models/car.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccessoriesWidget extends StatelessWidget {
  const AccessoriesWidget({Key? key, required this.carItem}) : super(key: key);
  final Car carItem;
  List<String> existAccessNames() {
    List<String> keys = [];
    carItem.singleAccessories.forEach((key, value) {
      if (value) {
        keys.add(key);
      }
    });
    return keys;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      verticalDirection: VerticalDirection.down,
      children: existAccessNames()
          .map((e) => FittedBox(
        fit: BoxFit.contain,
            child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      e,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
          ))
          .toList(),
    );
  }
}
