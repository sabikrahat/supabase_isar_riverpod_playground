import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'awesome_snackbar.dart';
import 'timer_snackbar.dart';

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

void showTimerSnackbar(BuildContext context, String message,
        [int second = 3]) =>
    timerSnackbar(context, contentText: message, second: second);

void showAwesomeSnackbar(BuildContext context, String title, String message, MessageType messageType, [int? second]) {
  // EasyLoading.dismiss();
  if (EasyLoading.isShow) EasyLoading.dismiss();
  //
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: Duration(
        seconds: second ?? (messageType == MessageType.failure ? 5 : 3)),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      messageType: messageType,
    ),
  );

  // EasyLoading.dismiss();
  if (EasyLoading.isShow) EasyLoading.dismiss();

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
