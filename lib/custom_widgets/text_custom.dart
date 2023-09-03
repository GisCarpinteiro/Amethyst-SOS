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
  static const String infoStyle = 'info_text';
  static const String subtitleStyle = 'subtitle';

  final String text;
  final Color? textColor;
  final double? size;
  final String? style;
  final IconData? icon;
  final double? iconSize;

  const TextCustomWidget(this.text,{
    super.key,
    this.size,
    this.style, 
    this.icon, 
    this.iconSize = 28,
    this.textColor
    });

  @override
  Widget build(BuildContext context) {
    switch (style){
      //NORMAL TEXT STYLE
      case TextCustomWidget.normalStyle: //normal is the default font
        return Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size?? 14,
              color: textColor?? const Color(0xFF5E5D5D)
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
      case TextCustomWidget.buttonStyle: 
        return Text(
          text.toUpperCase(), 
          style: GoogleFonts.lexend(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size?? 18,
              color: textColor
            )
          )
        );
      // GENERIC SECTION/SCREEN TITLE STYLE
      case TextCustomWidget.sectionTitleStyle:
        if (icon != null){
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.toUpperCase(), 
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: GoogleFonts.lexend(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: size?? 24,
                    color: textColor?? const Color(0xFF6A6868)
                  )
                )
              ),
              const SizedBox(width: 6,),
              Icon(icon, size: iconSize, color: textColor?? const Color(0xFF6A6868), weight: 1,),
            ],
          );
        } 
        else {
          return Text(
            text.toUpperCase(), 
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              textStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24,
                color: textColor?? const Color(0xFF6A6868)
              )
            )
          );
        }
      case TextCustomWidget.subtitleStyle:
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            children: [
              if (icon != null) Icon(icon, 
                size: 16, 
                color: textColor?? const Color(0xFF5E5D5D),
              ),
              if (icon != null) const SizedBox(width: 5,),
              Text(
                  
                  text.toUpperCase(), 
                  //textAlign: TextAlign.start,
                  style: GoogleFonts.lexend(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: textColor?? const Color(0xFF5E5D5D)
                    )
                  )
              ),
            ],
          ),
        );
      // STYLE FOR INFO/DESCRIPTION TEXT
      case TextCustomWidget.infoStyle:
        return Text(
          textAlign: TextAlign.justify,
          text, 
          style: GoogleFonts.lexend(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size?? 12,
              color: textColor?? const Color(0xFF5E5D5D)
            )
          )
        );
      // DEFAULT TEXT STYLE
      default:  
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