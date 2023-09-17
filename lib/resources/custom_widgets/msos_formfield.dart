import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';

class MSosFormField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final Color onFocusBorderColor;
  const MSosFormField({
    super.key,
    this.hintText = "",
    this.initialValue = "",
    this.onFocusBorderColor = MSosColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: 6,
        minLines: 1,
        cursorColor: onFocusBorderColor,
        style: GoogleFonts.lexend(textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: MSosColors.grayDark)),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: MSosColors.grayDark)),
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
      ),
    );
  }
}
