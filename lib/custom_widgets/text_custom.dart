import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/* This class allow us to manage text widgets by defining predifined styles for 
re usability */

class TextCustomWidget extends StatelessWidget {
  static const String normalStyle = 'normal';
  static const String wizardTitleStyle = 'wizard_title';
  static const String sectionTitleStyle = 'section_title';
  static const String textboxLabelStyle = 'textbox_label';
  static const String buttonStyle = 'button';
  static const String nudeStyle = 'nude_button';

  final String text;
  final double? size;
  final String? style;

  const TextCustomWidget(this.text,{super.key,this.size = 18,this.style});

  @override
  Widget build(BuildContext context) {
    switch (style){
      //NORMAL TEXT STYLE
      case TextCustomWidget.normalStyle: //normal is the default font
        return Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            )
          )
        );
      // WIZARD SECTION TITLE STYLE
      case TextCustomWidget.wizardTitleStyle: //wizardTitleWidget is bold and "UpperCased"
        return Text(
          text.toUpperCase(), 
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24
            )
          )
        );
      // HYPERLINK TEXT
      case TextCustomWidget.nudeStyle: //normal is the default font
        return Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF5E5D5D)
            )
          )
        );
      // TEXTBOX LABEL TEXT STYLE
      case TextCustomWidget.textboxLabelStyle: 
        return Text(
          text.toUpperCase(), 
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xFF999999)
            )
          )
        );
      // PINK BUTTON TEXT STYLE
      case TextCustomWidget.buttonStyle: // TODO: define a title style for the appViews
        return Text(
          text.toUpperCase(), 
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xFFFFFFFF)
            )
          )
        );
      // GENERIC SECTION/SCREEN TITLE STYLE
      case TextCustomWidget.sectionTitleStyle: // TODO: define a title style for the appViews
        return Text(
          text, 
          style: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24
            )
          )
        );
      // DEFAULT TEXT STYLE
      default:  // TODO: define a default style, for now it's just the normal one.
        return Text(
          text, 
          style: GoogleFonts.lexend(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size
            )
          )
        );
    }
  }
}