import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';

/* This class allow us to manage text widgets by defining predifined styles for 
re usability */

class MSosText extends StatelessWidget {
  static const String normalStyle = 'normal';
  static const String wizardTitleStyle = 'wizard_title';
  static const String sectionTitleStyle = 'section_title';
  static const String textboxLabelStyle = 'textbox_label';
  static const String buttonStyle = 'button';
  static const String nudeStyle = 'nude_button';
  static const String infoStyle = 'info_text';
  static const String subtitleStyle = 'subtitle';

  final String text;
  final Color? textColor;
  final double? size;
  final String? style;
  final IconData? icon;
  final double? iconSize;
  final bool? isMultiline;
  final TextAlign alignment;

  const MSosText(this.text,
      {super.key,
      this.isMultiline,
      this.size,
      this.style,
      this.icon,
      this.iconSize = 28,
      this.textColor,
      this.alignment = TextAlign.justify});

  @override
  Widget build(BuildContext context) {
    switch (style) {
      //NORMAL TEXT STYLE
      case MSosText.normalStyle: //normal is the default font
        return Text(text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.lexend(
                textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size ?? 14,
              color: textColor ?? MSosColors.grayDark,
            )));
      // WIZARD SECTION TITLE STYLE
      case MSosText.wizardTitleStyle: //wizardTitleWidget is bold and "UpperCased"
        return Text(text.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            )));
      // HYPERLINK TEXT
      case MSosText.nudeStyle: //normal is the default font
        return Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: MSosColors.grayDark,
            )));
      // TEXTBOX LABEL TEXT STYLE
      case MSosText.textboxLabelStyle:
        return Text(text.toUpperCase(),
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: MSosColors.grayLight,
            )));
      // PINK BUTTON TEXT STYLE
      case MSosText.buttonStyle:
        return Text(text.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.lexend(
                textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size ?? 18,
              color: textColor ?? MSosColors.white,
            )));
      // GENERIC SECTION/SCREEN TITLE STYLE
      case MSosText.sectionTitleStyle:
        if (icon != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text.toUpperCase(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.lexend(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: size ?? 24,
                    color: textColor ?? MSosColors.grayDark,
                  ))),
              const SizedBox(
                width: 6,
              ),
              Icon(
                icon,
                size: iconSize,
                color: textColor ?? MSosColors.grayDark,
                weight: 1,
              ),
            ],
          );
        } else {
          return Text(text.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24,
                color: textColor ?? MSosColors.grayDark,
              )));
        }
      case MSosText.subtitleStyle:
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 16,
                  color: textColor ?? MSosColors.grayDark,
                ),
              if (icon != null)
                const SizedBox(
                  width: 5,
                ),
              Text(
                text.toUpperCase(),
                //textAlign: TextAlign.start,
                style: GoogleFonts.lexend(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor ?? MSosColors.grayDark,
                )),
              ),
            ],
          ),
        );
      // STYLE FOR INFO/DESCRIPTION TEXT
      case MSosText.infoStyle:
        return Text(
            textAlign: TextAlign.justify,
            text,
            style: GoogleFonts.lexend(
                textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size ?? 12,
              color: textColor ?? MSosColors.grayDark,
            )));
      // DEFAULT TEXT STYLE
      default:
        return Text(text,
            textAlign: alignment,
            maxLines: isMultiline == true ? 10 : 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lexend(
                textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size ?? 14,
              color: textColor ?? MSosColors.grayDark,
            )));
    }
  }
}
