import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/custom_widgets/btn_custom.dart';


/* Es la página 404 not found, usada para poder probar la funcionalidad de ruteo
sin ser redirigido a una página random */

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  

  @override
  Widget build(BuildContext context) {

    //Obtaining screen dimensions for easier to read code.
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false, //Used to not resize when keyboard appears
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 60, 40, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('404!',
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 100,
                  color: Color(0xFFef8496)
                )
              )
            ),
            Text('¿Cómo has llegado hasta aquí? 🤔',
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 44,
                  color: Color(0xFF5E5D5D)
                )
              )
            ),
            const BtnCustomWidget(text: 'Llévame al inicio!', route: '/test_demo', style: BtnCustomWidget.continueLargeBtn)
          ]),
          )
      ),
    );
  }
}




