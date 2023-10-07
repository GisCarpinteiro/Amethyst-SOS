import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_formfields/msos_normal_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_formfields/msos_wizard_formfield.dart';

enum MSosFormFieldStyle {
  normal,
  wizard,
}

class MSosFormField extends StatelessWidget {
  final String? label;
  final String hintText;
  final Color onFocusBorderColor;
  final TextInputType? inputType;
  final TextEditingController controller;
  final bool isMultiLine;
  final bool resetOnClick;
  final MSosFormFieldStyle style;
  final IconData? icon;

  const MSosFormField(
      {super.key,
      this.hintText = "",
      this.onFocusBorderColor = MSosColors.blue,
      this.inputType,
      this.label = "",
      this.isMultiLine = false,
      this.resetOnClick = false,
      this.style = MSosFormFieldStyle.normal,
      this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MSosFormFieldStyle.normal:
        return MSosFF(
            controller: controller,
            hintText: hintText,
            onFocusBorderColor: onFocusBorderColor,
            inputType: inputType,
            label: label,
            isMultiLine: isMultiLine,
            resetOnClick: resetOnClick,
            icon: icon);
      case MSosFormFieldStyle.wizard:
        return MSosWizardFF(
            controller: controller,
            hintText: hintText,
            onFocusBorderColor: onFocusBorderColor,
            inputType: inputType,
            label: label,
            isMultiLine: isMultiLine,
            resetOnClick: resetOnClick,
            icon: icon);
    }
  }
// Here we decide the style is applied to the formField within the ones defined on the MSosFormFieldStyle
}
