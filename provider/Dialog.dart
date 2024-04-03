import 'dart:html';

import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context, String dipMessage)async {
  AlertDialog dialog = AlertDialog(
      title: const Text("Xac Nhan"),
      content: Text(dipMessage),
      actions: [
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context, rootNavigator: true,).pop("cancel"),
          child: Text('HUY'),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context, rootNavigator: true,).pop("ok"),
          child: Text('OK'),
        ),
      ]
  );
  String? res = await showDialog<String?>(
    context:context,
    barrierDismissible: false,
    builder:(context)=>dialog,
  );
  return res;
}