import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

void hideDialog(BuildContext context) {
  Navigator.pop(context);
}

Future<void> showMessage(BuildContext context,
    {String? title,
    String? body,
    String? posButtonTitle,
    String? negativeButtonTitle,
    Function? onPosButtonClick,
    Function? onNegativeButtonClick,
    bool isDismissible = true}) {
  return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posButtonTitle != null)
              ElevatedButton(
                onPressed: () {
                  onPosButtonClick?.call();
                  hideDialog(context);
                },
                child: Text(posButtonTitle),
              ),
            if (negativeButtonTitle != null)
              ElevatedButton(
                onPressed: () {
                  onNegativeButtonClick?.call();
                  hideDialog(context);
                },
                child: Text(negativeButtonTitle),
              ),
          ],
        );
      });
}
