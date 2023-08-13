import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/text_custom.dart';
import '../custom_widgets/labeled_textbox_custom.dart';
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
  
  @override
  Widget build(BuildContext context) {

    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            ClipRect(
              child: Image.asset(
                'lib/assets/wizard_landscape.png',
                fit: BoxFit.cover
                ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //------------> This containar is used only to make dynamic the size that the image shows
                  Container(
                    height: screenHeight * 0.15,
                    decoration: const BoxDecoration(
                    )
                  ),
                  Container(
                    height: screenHeight * 0.85,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
// ---------------> THIS COLUMN COULD BE SEEN AS THE ACTUAL CONTENT BODY OF THIS VIEW TEMPLATE
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12 , 30, screenWidth * 0.12, 30
                      ),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustomWidget( //Custom widget for predifined text style generation.
                            'Registro', 
                            style: TextCustomWidget.wizardTitleStyle,
                          ),
                          FormCustomWidget(formKey: _formKey),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextCustomWidget( //Custom widget for predifined text style generation.
                                '¿Ya tienes una cuenta?', 
                                style: TextCustomWidget.normalStyle,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0x00000000),
                                  fixedSize: Size(screenWidth * 0.6, 44)
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login'); 
                                }, 
                                child: const TextCustomWidget( //Custom widget for predifined text style generation.
                                  'Acceder', 
                                  style: TextCustomWidget.nudeStyle,
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
        )
      ),
    );
  }
}



class FormCustomWidget extends StatelessWidget {
  const FormCustomWidget({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    //gender options list for DropdownButtonFormField
    const List<String> items = ['Femenino', 'Masculino', 'No binario'];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Form(
            key: _formKey,
            child: const Column(
              children: [
                LabeledTextBoxCustomWidget(
                  label: 'País',
                  placeholder: 'México',
                  type: LabeledTextBoxCustomWidget.normal,
                ),
                SizedBox( height: 20,),
                LabeledTextBoxCustomWidget(
                  label: 'Teléfono',
                  type: LabeledTextBoxCustomWidget.normal,
                  icon: Icon(Icons.face_3_rounded, color: Color(0xFF999999), size: 16,),
                ),
                SizedBox( height: 20,),
                CustomDropDownWidget(label: 'Género', items: items),
                SizedBox( height: 20,),
                LabeledTextBoxCustomWidget(
                  label: 'Fecha de Nacimiento',
                  placeholder: '01/01/2000',
                  type: LabeledTextBoxCustomWidget.normal,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:const Color(0xFFEF8496),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      Navigator.pushNamed(context, '/confirm_email');
                    } else {ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos Inválidos'))
                      );
                    } // go to next screen
                  }, 
                  child: const TextCustomWidget(
                    "Siguiente",
                    style: TextCustomWidget.buttonStyle,
                  )
                ),
              ),
            ]
          )
        ],
      ),
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
  static const Color color = Color(0xFF999999);
  static const Color _focussedBorderColor = Color(0xFF7CC5E4);
  final String label;

  @override
  Widget build(BuildContext context) {
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
        DropdownButtonFormField( //TODO: Enhance the syle of the dropdown menu to be rounded
          items: items.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.lexend(textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Color(0xFF999999)
                ))
              )
            );
          }).toList(),
          onChanged:(value) {
          },
          value: 'Femenino',
          decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 10, 12),
          isCollapsed: true,
          border: OutlineInputBorder(
          //----------  >The border radius value could be more than needed to force "roundness"
            borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder: OutlineInputBorder(
          //----------  >The border radius value could be more than needed to force "roundness"
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: _focussedBorderColor,
              width: 2.0
            )
          ),
          hintText: '*******',
          hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Color(0xFF999999)
            )
          )
        ),
        ),
      ],
    );
  }
}




