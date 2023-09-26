import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';

// See that all the flushbar derivate custom widgets are not really widgets but classes that allow us to popUp messages or menus.
class MSosPopUpMenu {
  late Flushbar<List<String>> popUpFlushMenu;
  List<Widget> formChildren;
  final VoidCallback? acceptCallbackFunc;
  final VoidCallback? cancelCallbackFunc;

  MSosPopUpMenu(
    BuildContext context, {
    required formKey,
    required this.formChildren,
    this.acceptCallbackFunc,
    this.cancelCallbackFunc,
  }) {
    popUpFlushMenu = Flushbar<List<String>>(
      backgroundColor: MSosColors.white,
      animationDuration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(10),
      blockBackgroundInteraction: true,
      routeBlur: 3,
      borderRadius: BorderRadius.circular(10),
      boxShadows: const [BoxShadow(color: MSosColors.grayDark, blurRadius: 2)],
      userInputForm: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: formChildren,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MSosButton(text: "Cancelar", style: MSosButton.smallButton, color: MSosColors.pink, callbackFunction: dismissPopUpMenu),
                  MSosButton(
                    text: "Aceptar",
                    style: MSosButton.smallButton,
                    color: MSosColors.blue,
                    callbackFunction: acceptCallbackFunc,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> showPopUpMenu(context) {
    popUpFlushMenu.show(context).then((result) {
      if (result != null) {
        // TODO
      }
    });
    return {};
  }

  void dismissPopUpMenu() {
    cancelCallbackFunc;
    popUpFlushMenu.dismiss(List.empty()).then((result) {});
  }
}
