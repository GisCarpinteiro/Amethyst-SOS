import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

/* Este es un widget custom que define la plantilla de un TextBox acompañado de 
una etiqueta, usado para los campos de los formularios dentro de la app */

class MSosWizardTextBox extends StatelessWidget {

  //parameters
  final String label;
  final String? placeholder;
  final String? type;
  final Icon? icon;
  
  static const String normal = 'normal_input_type';
  static const String email = 'email_input_type';
  static const String password = 'password_input_type';
  static const String phone = 'phone_number_input_type';

  //constant
  static const Color color = Color(0xFF999999);
  static const Color focussedBorderColor = Color(0xFF7CC5E4);

  const MSosWizardTextBox({
    required this.label,
    this.placeholder = '',
    this.type = normal,
    this.icon = const Icon(Icons.text_fields_rounded, color: color, size: 18,),
    super.key,
  });

  //REGEX VALIDATIONS
  // For password we check that it is at least 8 characters long, has at least 1 number and no spaces.  
  static RegExp passwordMatchAtLeast8 = RegExp(r'^.{8,}$', caseSensitive: false, multiLine: false);
  static RegExp passwordMatchNoSpaces = RegExp(r'^[^\s]+$', caseSensitive: false, multiLine: false);
  static RegExp passwordMatchAtLeast1Digit = RegExp(r'\d', caseSensitive: false, multiLine: false);
  static RegExp passwordMatchAtLeast1Letter = RegExp(r'[a-zA-Z]', caseSensitive: false, multiLine: true);
  static RegExp phoneMatcher = RegExp(r'\d{8}', caseSensitive: false, multiLine: false);
  
  passwordValidation(value){
    if (value == null || value.isEmpty){
      return 'Defina una contraseña!';
    } else if (!passwordMatchAtLeast8.hasMatch(value)){
      return  'Debe tener mínimo 8 caracteres!';
    } else if (!passwordMatchNoSpaces.hasMatch(value)){
      return  'No debe incluir espacios!';
    } else if (!passwordMatchAtLeast1Digit.hasMatch(value)){
      return  'Debe tener al menos un número!';
    } else if (!passwordMatchAtLeast1Letter.hasMatch(value)){
      return  'Debe tener al menos una letra!';
    } else {return null;}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr, child: chooseText());
  }

  Widget chooseText(){
    switch (type){
      case normal:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(
              '   ${label.toUpperCase()}', 
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF999999)
                ),
              )
            ),
            const SizedBox(height: 8,),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 6),
                isCollapsed: true,
                suffixIcon: icon,
                border: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: focussedBorderColor,
                    width: 2.0
                  )
                ),
                hintText: placeholder,
                hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: color
                  )
                )
              ),
            )
          ],
        );
// TEXTBOX ESPECÍFICO PARA PASSWORD.
      //TODO: Definir cuáles serán los requisitos para la contraseña para hacer su validación.
      case password:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '   ${label.toUpperCase()}', 
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF999999)
                ),
              )
            ),
            const SizedBox(height: 8,),
            TextFormField(
              validator: (value){
                return passwordValidation(value);
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 6),
                isCollapsed: true,
                suffixIcon: const Icon(Icons.key_rounded, color: color, size: 18,),
                border: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30)
                ),
                focusedBorder: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: focussedBorderColor,
                    width: 2.0
                  )
                ),
                hintText: '*******',
                hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: color
                  )
                )
              ),
            )
          ],
        );
      case email:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Text(
              '   ${label.toUpperCase()}', 
              textDirection: TextDirection.ltr,
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF999999)
                ),
              )
            ),
            const SizedBox(height: 8,),
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Ingresa tu correo';
                } else {
                  return EmailValidator.validate(value) ? null : 'Ingresa un correo válido';
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 6),
                isCollapsed: true,
                suffixIcon: const Icon(Icons.email_rounded, color: Color(0xFF999999), size: 18,),
                border: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30)
                ),
                focusedBorder: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: focussedBorderColor,
                    width: 2.0
                  )
                ),
                hintText: 'MiCorreo@gmail.com',
                hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: color
                  )
                )
              ),
            )
          ],
        );
      case phone: 
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '   ${label.toUpperCase()}', 
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF999999)
                ),
              )
            ),
            const SizedBox(height: 8,),
            TextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Ingresa tu número de teléfono celular';
                } else {
                  return EmailValidator.validate(value) ? null : 'Ingresa un teléfono válido';
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 6),
                isCollapsed: true,
                suffixIcon: icon,
                border: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
    //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: focussedBorderColor,
                    width: 2.0
                  )
                ),
                hintText: placeholder,
                hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: color
                  )
                )
              ),
            )
          ],
        );
      default: 
        return const Text('Aquí debería haber un widget :(');
    }
  }
  
}
