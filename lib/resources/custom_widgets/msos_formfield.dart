import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_formfields/msos_normal_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_formfields/msos_wizard_formfield.dart';

enum MSosFormFieldStyle {
  normal,
  wizard,
}

// * This enum is to define the different kinds of validations that could be applied
enum MSosFormFieldValidation {
  password,
  email,
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
  final MSosFormFieldValidation? validation;

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
      this.validation,
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
            validation: validation,
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
            validation: validation,
            icon: icon);
    }
  }

  String? passwordValidation(String? value) {
    final RegExp passwordMatchAtLeast8 = RegExp(r'^.{8,}$', caseSensitive: false, multiLine: false);
    final RegExp passwordMatchNoSpaces = RegExp(r'^[^\s]+$', caseSensitive: false, multiLine: false);
    final RegExp passwordMatchAtLeast1Digit = RegExp(r'\d', caseSensitive: false, multiLine: false);
    final RegExp passwordMatchAtLeast1Letter = RegExp(r'[a-zA-Z]', caseSensitive: false, multiLine: true);

    if (value == null || value.isEmpty) {
      return 'Defina una contraseña!';
    } else if (!passwordMatchAtLeast8.hasMatch(value)) {
      return 'Debe tener mínimo 8 caracteres!';
    } else if (!passwordMatchNoSpaces.hasMatch(value)) {
      return 'No debe incluir espacios!';
    } else if (!passwordMatchAtLeast1Digit.hasMatch(value)) {
      return 'Debe tener al menos un número!';
    } else if (!passwordMatchAtLeast1Letter.hasMatch(value)) {
      return 'Debe tener al menos una letra!';
    } else {
      return null;
    }
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu correo';
    } else {
      return EmailValidator.validate(value) ? null : 'Ingresa un correo válido';
    }
  }
}
