import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosWizardFF extends MSosFormField {
  const MSosWizardFF(
      {super.key,
      required super.controller,
      super.hintText = "",
      super.onFocusBorderColor = MSosColors.blue,
      super.inputType,
      super.label = "",
      super.isMultiLine = false,
      super.resetOnClick = false,
      super.icon,
      super.validation})
      : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? MSosText(
                  "   $label",
                  style: MSosText.textboxLabelStyle,
                )
              : const SizedBox(height: 0), // We add the title only if defined.
          TextFormField(
            // TextFormField widget can only have a controller or an initial value, so we have to make sure one takes over the other if both passed as parameters, in this case controller has priority
            controller: controller,
            keyboardType: inputType,
            maxLines: isMultiLine ? 6 : 1,
            minLines: 1,
            obscureText: validation == MSosFormFieldValidation.password ? true : false,
            onTap: resetOnClick ? () => controller.text = "" : null,
            cursorColor: onFocusBorderColor,
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: MSosColors.grayDark,
            )),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
                isCollapsed: false,
                prefixIcon: SizedBox(
                  width: 30,
                  child: Icon(
                    icon ?? Icons.text_fields_rounded,
                    color: MSosColors.grayLight,
                    size: 18,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: MSosColors.grayMedium, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                    //----------  >The border radius value could be more than needed to force "roundness"
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: MSosColors.blue, width: 2.0)),
                hintText: hintText,
                hintStyle: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 1,
                  color: MSosColors.grayLight,
                ))),
            // This function is needed to update the value from textField and update it with Bloc State, if using controller this one is no needed since you can read the value from controller.
            validator: (value) {
              switch (validation) {
                case null:
                  return null;
                case MSosFormFieldValidation.password:
                  return passwordValidation(value);
                case MSosFormFieldValidation.email:
                  return emailValidation(value);
                case MSosFormFieldValidation.phone:
                  return phoneValidation(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
