import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';
import 'package:google_fonts/google_fonts.dart';

/* Esta vista es la segunda parte de la creación de la sección de creación de cuenta */

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen2> {
  //Key used for the login formulary
  final _formKey = GlobalKey<FormState>();
  final countryCtrlr = TextEditingController();
  final phoneCtrlr = TextEditingController();
  final birthDayCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    const List<String> items = ['Femenino', 'Masculino', 'No binario'];

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: Container(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ClipRect(
                child: Image.asset('lib/assets/wizard_landscape.png', fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //------------> This containar is used only to make dynamic the size that the image shows
                    Container(height: screenHeight * 0.15, decoration: const BoxDecoration()),
                    Container(
                      height: screenHeight * 0.85,
                      width: screenWidth,
                      decoration: BoxDecoration(color: MSosColors.white, borderRadius: BorderRadius.circular(20)),
// ---------------> THIS COLUMN COULD BE SEEN AS THE ACTUAL CONTENT BODY OF THIS VIEW TEMPLATE
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 30, screenWidth * 0.12, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MSosText(
                              //Custom widget for predifined text style generation.
                              'Registro',
                              style: MSosText.wizardTitleStyle,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        MSosFormField(
                                          label: "País",
                                          controller: countryCtrlr,
                                          style: MSosFormFieldStyle.wizard,
                                          icon: FontAwesomeIcons.earthAmericas,
                                        ),
                                        const SizedBox(height: 10),
                                        MSosFormField(
                                          controller: phoneCtrlr,
                                          label: "Teléfono Celular",
                                          style: MSosFormFieldStyle.wizard,
                                          icon: FontAwesomeIcons.phone,
                                        ),
                                        const SizedBox(height: 10),
                                        const CustomDropDownWidget(label: 'Género', items: items),
                                        const SizedBox(height: 10),
                                        MSosFormField(
                                          label: 'Fecha de Nacimiento',
                                          controller: birthDayCtrl,
                                          style: MSosFormFieldStyle.wizard,
                                          icon: FontAwesomeIcons.cakeCandles,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(children: [
                                    // TODO: Change for MSOS Button
                                    Expanded(
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: MSosColors.pink,
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              Navigator.pushNamed(context, '/confirm_email');
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Datos Inválidos')));
                                            } // go to next screen
                                          },
                                          child: const MSosText(
                                            "Siguiente",
                                            style: MSosText.buttonStyle,
                                          )),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const MSosText(
                                  //Custom widget for predifined text style generation.
                                  '¿Ya tienes una cuenta?',
                                  style: MSosText.normalStyle,
                                ),
                                TextButton(
                                  style:
                                      TextButton.styleFrom(backgroundColor: MSosColors.transparent, fixedSize: Size(screenWidth * 0.6, 44)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const MSosText(
                                    //Custom widget for predifined text style generation.
                                    'Acceder',
                                    style: MSosText.nudeStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class CustomDropDownWidget extends StatelessWidget {
  const CustomDropDownWidget({
    super.key,
    required this.label,
    required this.items,
  });

  final List<String> items;
  static const Color color = MSosColors.grayLight;
  static const Color _focussedBorderColor = MSosColors.blue;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('   ${label.toUpperCase()}',
            style: GoogleFonts.lexend(
              textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: MSosColors.grayLight),
            )),
        DropdownButtonFormField(
          icon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(
              FontAwesomeIcons.venusMars,
              size: 22,
              color: MSosColors.grayLight,
            ),
          ),
          //TODO: Enhance the syle of the dropdown menu to be rounded
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: GoogleFonts.lexend(
                        textStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: MSosColors.grayLight))));
          }).toList(),
          onChanged: (value) {},
          value: 'Femenino',
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 10, 12),
              isCollapsed: true,
              border: OutlineInputBorder(
                  //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  //----------  >The border radius value could be more than needed to force "roundness"
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: _focussedBorderColor, width: 2.0)),
              hintText: '*******',
              hintStyle:
                  GoogleFonts.lexend(textStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: MSosColors.grayLight))),
        ),
      ],
    );
  }
}
