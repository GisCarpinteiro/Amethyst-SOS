import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/providers/alert_button_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';
import 'package:vistas_amatista/services/alert_service.dart';

class MSosAlertButton extends StatelessWidget {
  const MSosAlertButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AlertButtonProvider state = context.watch<AlertButtonProvider>();
    final AlertButtonProvider provider = context.read<AlertButtonProvider>();
    bool keyBoardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Visibility(
      visible: !keyBoardIsOpen,
      child: FloatingActionButton.large(
          backgroundColor: state.alertButtonEnabled ? MSosColors.pink : MSosColors.grayDark,
          shape: const CircleBorder(),
          onPressed: () {
            if (!AlertService.isServiceActive) return;
            // TODO: Implementar las alertaaaas!!!
            if (!state.alertCoundownActivated) {
              // If the alert is not under countdown activation we start it on press
              provider.startAlertCountdown(toleranceSeconds: AlertService.selectedAlert!.toleranceSeconds);
              MSosFloatingMessage.showMessage(context,
                  message: "¡Se ha activado la alerta!", type: MSosMessageType.alert);
            } else {
              provider.terminateAlertCountdown();
            }
          },
          child: state.alertCoundownActivated
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MSosText("${state.minutesLeft}:${state.secondsLeft}", textColor: MSosColors.white, size: 20),
                    const FaIcon(FontAwesomeIcons.stop, color: MSosColors.white, size: 22)
                  ],
                )
              : FaIcon(
                  FontAwesomeIcons.solidPaperPlane,
                  color: state.alertButtonEnabled ? MSosColors.white : MSosColors.grayLight,
                )),
    );
  }
}
