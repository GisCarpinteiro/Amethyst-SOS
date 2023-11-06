import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosFF extends MSosFormField {
  const MSosFF(
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
          label != null ? MSosText(" $label") : const SizedBox(height: 0), // We add the title only if defined.
          TextFormField(
            // TextFormField widget can only have a controller or an initial value, so we have to make sure one takes over the other if both passed as parameters, in this case controller has priority
            controller: controller,
            keyboardType: inputType,
            maxLines: isMultiLine ? 6 : 1,
            minLines: 1,
            onTap: resetOnClick ? () => controller.text = "" : null,
            cursorColor: onFocusBorderColor,
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: MSosColors.grayDark,
            )),
            decoration: InputDecoration(
              hintStyle: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: MSosColors.grayDark,
              )),
              contentPadding: const EdgeInsets.all(10),
              isCollapsed: true,
              hintText: hintText,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: MSosColors.grayLight),
                  //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: onFocusBorderColor, width: 2.0)),
            ),
            validator: (value) {
              switch (validation) {
                case null:
                  return standardValidation(value);
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
