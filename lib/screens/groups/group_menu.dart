import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/blocs/group_blocs/group_menu/group_menu_bloc.dart';
import 'package:vistas_amatista/models/contact.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class GroupMenuScreen extends StatelessWidget {
  const GroupMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;
    //Key used for the login formulary
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<GroupMenuBloc, GroupMenuState>(
      builder: (context, state) {
        // We read if either is the Edition Screen or the Creation Screen
        bool isEdition = state.isGroupEditionContext;
        // Inicialization of some variables for widgets that need re renderization to work

        return Scaffold(
          resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
          appBar: MSosAppBar(title: isEdition ? "Editar Grupo" : "Crear Grupo", icon: Icons.crisis_alert),
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
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          MSosText(
                            isEdition ? state.group!.name : "Nuevo Grupo",
                            style: MSosText.subtitleStyle,
                            icon: Icons.add_circle_rounded,
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const MSosText("Nombre del Grupo"),
                              MSosFormField(initialValue: isEdition ? state.group!.name : "Nuevo Grupo"),
                              const SizedBox(height: 10),
                              const MSosText("Lista de contactos"),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: state.group!.contacts.length * 70,
                                child: ListView.separated(
                                  itemCount: state.group!.contacts.length,
                                  separatorBuilder: (BuildContext context, int index) => const Divider(
                                    height: 8,
                                    color: MSosColors.white,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    // We get the contact from the map list contained by group under the name of contacts
                                    Contact contact = Contact.fromJson(state.group!.contacts[index]);
                                    return MSosListItemCard(title: contact.name, callback: () {});
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.person_add_rounded),
                                  onPressed: () {
                                    if (state.group!.contacts.length > 1) {
                                      MSosSnackBar.showInfoMessage(context,
                                          message: "Solo puedes añadir un máximo de 5 contactos", title: "Lo sentimos...");
                                    }
                                  },
                                  color: MSosColors.white,
                                  style: IconButton.styleFrom(
                                      backgroundColor: state.group!.contacts.length <= 5 ? MSosColors.blue : MSosColors.grayLight)),
                              const SizedBox(height: 10),
                              MSosButton(
                                text: "Guardar",
                                style: MSosButton.smallButton,
                                color: MSosColors.blue,
                                callbackFunction: () {
                                  /* TODO: Necesitamos implementar dos cosas: 
                                  1 - Debemos dar opción de agregar contactos desde su lista de contactos
                                  2 - Debemos dar opción de agregar un contact con su nombre y su número de teléfonos ingresados desde una vista o un popUp.*/
                                },
                              )
                            ]),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
