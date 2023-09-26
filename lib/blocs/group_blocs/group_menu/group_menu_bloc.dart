import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/group.dart';

part 'group_menu_event.dart';
part 'group_menu_state.dart';

class GroupMenuBloc extends Bloc<GroupMenuEvent, GroupMenuState> {
  GroupMenuBloc() : super(const GroupMenuInitial$()) {

    // Comming from GroupList -> Create Group
    on<InitialCreateGroupEvent>((event, emit) {
      emit(const SetGroupCreationContext$());
      Navigator.pushNamed(event.context, '/group_menu');
    });
    
    // When pressing Create on GroupMenu Screen with creation context
    on<CreateGroupEvent>((event, emit) {
      GroupController.createGroup(event.group);
    });

    // Comming from GroupList -> Edit Group:
    on<GetGroupEvent>((event, emit) {
      emit(const SetGroupCreationContext$());
      emit(EditGroup$(group: event.group));
      Navigator.pushNamed(event.context, '/group_menu');
    });

    on<UpdateGroupEvent>((event, emit) {
      // TODO: Implement UpdateAlert con ConfigurationJSon locally and remotly
    });
  }
}
