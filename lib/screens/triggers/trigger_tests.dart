import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/btn_custom.dart';
import 'package:vistas_amatista/custom_widgets/custom_app_bar.dart';
import 'package:vistas_amatista/custom_widgets/text_custom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class TriggerTestScreen extends StatefulWidget {
  const TriggerTestScreen({super.key});
  

  @override
  State<TriggerTestScreen> createState() => _TriggerTestScreenState();
}

class _TriggerTestScreenState extends State<TriggerTestScreen> {
  bool isTriggerEnabled = true;
  int? toleranceTimeValue = 0;
  final Connectivity _connectivity = Connectivity();
  bool isConnected = false;
  late StreamSubscription<ConnectivityResult> connectionSubscription;

  //Function to check connection to internet on Initial Screen Rendering
  void isConnectedToInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile){
      isConnected = true;
    } else{
      isConnected = false;
    }
  }

  @override
  void initState() {
    super.initState();
    // This is a channel used to listen to connectivity changes.
    connectionSubscription = Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void dispose() {
    connectionSubscription.cancel();
    super.dispose();
  }

  // Method to update connection status
  Future<void> updateConnectionStatus(ConnectivityResult result) async{
    print("Cambio la conexión");
      setState(() {
        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
          isConnected = true;
        } else{
          isConnected = false;
        } 
    });
  }
    
  @override
  Widget build(BuildContext context) {

    //Check for Internet Connection:
    isConnectedToInternet();

    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: const CustomAppBar(title: 'TriggerTesterScreen', icon: Icons.check_rounded),
      body: Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,  
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      TextCustomWidget(
                        "Internet Disconnection?", 
                        style: TextCustomWidget.subtitleStyle, 
                        icon: Icons.wifi_find, 
                        textColor: isConnected? Colors.green : Colors.red
                      ),
                      const SizedBox(height: 10,),
                      Container (
                        child: isConnected? const Icon(Icons.check_circle, key: Key("SuccessIcon"), size: 60, color: Colors.green,) 
                          : const Icon(Icons.cancel, key: Key("FailIcon"), size: 60, color: Colors.red,) 
                      )
                    ],
                  ),
                  const BtnCustomWidget(text: 'Regresar', route: '/not_found', style: BtnCustomWidget.continueLargeBtn)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
