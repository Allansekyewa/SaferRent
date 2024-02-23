import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            content: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.red, fontSize: 10),
            ),
            actions: buttons.entries.map((entry) {
              return TextButton(
                child: Text(
                  entry.key,
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                ),
                onPressed: () {
                  Navigator.of(context).pop(entry.value);
                },
              );
            }).toList(),
          );
        });
  }
}
