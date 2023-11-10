import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/contact.dart';
import 'package:vistas_amatista/providers/group_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class GroupMenuScreen extends StatefulWidget {
  const GroupMenuScreen({super.key});

  @override
  State<GroupMenuScreen> createState() => _GroupMenuScreenState();
}

class _GroupMenuScreenState extends State<GroupMenuScreen> {
  final contactNameController = TextEditingController();
  final groupNameController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;

    final state = context.watch<GroupProvider>();
    final provider = context.read<GroupProvider>();

    // PopUp Menu to add a new contact
    late final MSosPopUpMenu popUpFlushMenu;
    popUpFlushMenu = MSosPopUpMenu(context, formKey: contactFormKey, formChildren: [
      const MSosText("Nombre:"),
      MSosFormField(
        controller: contactNameController,
        resetOnClick: true,
      ),
      const MSosText("Teléfono"),
      MSosFormField(
        controller: phoneController,
        inputType: TextInputType.phone,
        resetOnClick: true,
        validation: MSosFormFieldValidation.phone,
      ),
    ], cancelCallbackFunc: () {
      // Reset the values from the popUp menu if cancel is pressed
      FlutterLogs.logInfo("tag", "subTag", "Canceled Action");
      contactNameController.text = "";
      phoneController.text = "";
    }, acceptCallbackFunc: () {
      if (contactFormKey.currentState!.validate()) {
        popUpFlushMenu.dismissPopUpMenu();
        if (!provider.createNewContact(contactName: contactNameController.text, phone: phoneController.text)) {
          MSosFloatingMessage.showMessage(context, message: "El contacto ya existe", type: MSosMessageType.alert);
        }
      }
    });

    // We read if either is the Edition Screen or the Creation Screen
    bool isEdition = state.isGroupEditionContext;
    // Inicialization of some variables for widgets that need re renderization to work
    if (groupNameController.text.isEmpty) groupNameController.text = state.group.name;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: MSosAppBar(title: isEdition ? "Editar Grupo" : "Crear Grupo", icon: Icons.crisis_alert),
      drawer: const MSosDashboard(),
      body: Container(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MSosText(
                          isEdition ? state.group.name : "Nuevo Grupo",
                          style: MSosText.subtitleStyle,
                          icon: Icons.add_circle_rounded,
                        ),
                        const SizedBox(height: 20),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const MSosText("Nombre del Grupo"),
                          MSosFormField(controller: groupNameController),
                          const SizedBox(height: 10),
                          const MSosText("Lista de contactos"),
                          const SizedBox(height: 10),
                          state.group.contacts.isEmpty
                              ? const MSosText(
                                  "Aún no ha añadido ningún contacto!",
                                  textColor: MSosColors.pink,
                                )
                              : SizedBox(
                                  height: state.group.contacts.length * 70,
                                  child: ListView.separated(
                                    itemCount: state.group.contacts.length,
                                    separatorBuilder: (BuildContext context, int index) => const Divider(
                                      height: 8,
                                      color: MSosColors.white,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      // We get the contact from the map list contained by group under the name of contacts
                                      Contact contact = Contact.fromJson(state.group.contacts[index]);
                                      return MSosListItemCard(title: contact.name, callback: () {});
                                    },
                                  ),
                                ),
                          const SizedBox(height: 10),
                          IconButton(
                              icon: const Icon(Icons.person_add_rounded),
                              onPressed: () {
                                if (state.group.contacts.length > 5) {
                                  MSosFloatingMessage.showMessage(context,
                                      message: "Solo puedes añadir un máximo de 5 contactos", title: "Lo sentimos...");
                                } else {
                                  // ignore: avoid_single_cascade_in_expression_statements
                                  popUpFlushMenu.showPopUpMenu(context);
                                }
                              },
                              color: MSosColors.white,
                              style: IconButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: MSosColors.grayLight,
                                  backgroundColor:
                                      state.group.contacts.length <= 5 ? MSosColors.blue : MSosColors.grayLight)),
                          const SizedBox(height: 10),
                          MSosButton(
                            text: "Guardar",
                            style: MSosButton.smallButton,
                            color: MSosColors.blue,
                            callbackFunction: () {
                              provider.saveGroup(groupName: groupNameController.text, context: context);
                            },
                          )
                        ])
                      ]),
                ],
              ),
            ),
          )),
    );
  }

  TextFormField getFormField(String text) {
    return TextFormField(
      initialValue: text,
      style: const TextStyle(color: Colors.white),
      maxLength: 100,
      maxLines: 1,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
          fillColor: Colors.white10,
          filled: true,
          icon: Icon(
            Icons.label,
            color: Colors.grey[500],
          ),
          border: const UnderlineInputBorder(),
          helperText: "Helper Text",
          helperStyle: const TextStyle(color: Colors.grey),
          labelText: "Label Text",
          labelStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
