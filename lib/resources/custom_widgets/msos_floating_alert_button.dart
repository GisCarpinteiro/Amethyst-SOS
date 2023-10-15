import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/bottombar_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';

class MSosAlertButton extends StatelessWidget {
  const MSosAlertButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarProvider barStatus = context.watch<BottomBarProvider>();
    return FloatingActionButton.large(
      backgroundColor: barStatus.alertButtonEnabled ? MSosColors.pink : MSosColors.grayMedium,
      shape: const CircleBorder(),
      onPressed: () {
        if (!AlertManager.isServiceActive) return;
        // TODO: Implementar las alertaaaas!!!
        MSosFloatingMessage.showMessage(context, message: "¡Se ha activado la alerta!", type: MessageType.alert);
      },
      child: Image.asset(
        'lib/resources/assets/images/alert_icon.png', // Ruta de la imagen dentro de la carpeta "assets"
        width: 70, // Ancho de la imagen
        height: 70,
      ),
    );
  }
}
