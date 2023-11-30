import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vistas_amatista/providers/group_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_floating_alert_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Screen used to view the list of configured groups, edit them or create a new one*/

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We trigger the event to fetch the groups on the screen inicialization
    final GroupProvider state = context.watch<GroupProvider>();

    final provider = context.read<GroupProvider>();
    provider.getGroupsList();

    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    return Scaffold(
        resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
        appBar: const MSosAppBar(title: 'Grupos', icon: Icons.people_alt_rounded),
        drawer: const MSosDashboard(),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: const CustomBottomAppBar(isFromGroupScreen: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: const MSosAlertButton(),
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
                            const MSosText(
                              "Grupos Creados",
                              style: MSosText.subtitleStyle,
                              icon: Icons.list,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state.groups.isEmpty
                                ? const MSosText(
                                    "Aún no ha creado ningún grupo!",
                                    textColor: MSosColors.pink,
                                  )
                                : SizedBox(
                                    height: state.groups.length * 70,
                                    child: ListView.separated(
                                      itemCount: state.groups.length,
                                      separatorBuilder: (BuildContext context, int index) => const Divider(
                                        height: 8,
                                        color: MSosColors.white,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return MSosListItemCard(
                                          title: state.groups[index].name,
                                          callback: () {
                                            provider.editGroupContext(context, state.groups[index]);
                                          },
                                          deleteCallback: () {
                                            provider.deleteGroup(targetGroup: state.groups[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                            MSosButton(
                              text: "Crear Grupo",
                              callbackFunction: () {
                                context.read<GroupProvider>().newGroupContext(context);
                              },
                              style: MSosButton.smallButton,
                              color: MSosColors.blue,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const MSosText(
                              "Los grupos pueden habilitarse en conjunto con una alerta para que el mensaje y la información definidos en ella sean enviados a todos tus contactos cuando se active",
                              size: 12,
                              style: MSosText.infoStyle,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
