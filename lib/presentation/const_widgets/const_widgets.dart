import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstWidgets {



  static void alertDialog ({required BuildContext context,required Widget content,required String title }){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text(title,textAlign: TextAlign.center,),
          content: content,
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
    alertDialog(context: context, content: Text('An error occurred: $error'),title: 'Error');
  }

  static Widget clickLink({required Uri link,required String name}){
    return InkWell(
      onTap: () {
        _launchURL(link);
      },
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  static void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Widget customCheckBox ({required String title,required Widget checkBox}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title),
        checkBox,
      ],
    );
  }


}