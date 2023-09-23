import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  GroupListBloc() : super(const GroupListInitial$()) {
    on<GetGroupsListEvent>((event, emit) {
      // We get the configured alerts from local data (sharedPreferences), if null we retry to restore them from database
      List<Group> groupList = GroupController.getGroups();
      emit(const GroupListInitial$());
      emit(GetGroupList$(groups: groupList));
    });

    on<CreateGroupEvent>((event, emit) {
      GroupController.createGroup(event.newGroup);
    });
  }
}
