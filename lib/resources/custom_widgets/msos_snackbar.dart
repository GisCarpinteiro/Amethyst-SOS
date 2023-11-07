// This class is used to create snackbar, that is the equivalent of a toast on android
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

// This class is used to show snackbars, the equivalent of Toast messages on android
enum MSosMessageType { info, alert, hint }

class MSosFloatingMessage {
  // Info message on Screen
  static void showMessage(BuildContext context,
      {required String message, String? title, Icon? icon, MSosMessageType? type}) {
    Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            flushbarPosition: FlushbarPosition.TOP,
            titleText: title != null
                ? MSosText(
                    title,
                    textColor: MSosColors.white,
                    size: 16,
                  )
                : null,
            icon: icon,
            messageText: MSosText(
              message,
              textColor: MSosColors.white,
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: switch (type) {
              null => MSosColors.grayMedium,
              MSosMessageType.info => MSosColors.blue,
              MSosMessageType.alert => MSosColors.pink,
              MSosMessageType.hint => MSosColors.grayMedium,
            })
        .show(context);
  }

  // Alert message on Screen
}
