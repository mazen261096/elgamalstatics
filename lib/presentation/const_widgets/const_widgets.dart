import 'package:flutter/material.dart';

class ConstWidgets {



  static void alertDialog ({required BuildContext context,required String message,required String title }){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static void handleError(BuildContext context, dynamic error) {
    alertDialog(context: context, message: 'An error occurred: $error',title: 'Error');
  }


}