part of 'group_list_bloc.dart';

sealed class GroupListEvent extends Equatable {
  const GroupListEvent();

  @override
  List<Object> get props => [];
}

class GetGroupsListEvent extends GroupListEvent {
  // * This event doesn't receive parameters since the info is obtained from shared preferences or firebase and no from the Screen nor other variables, so it is just used to trigger the state inicialization.
  const GetGroupsListEvent();
}

 // ? Maybe these ones need to be recreated?? Idk if they are functional as they are right now
class CreateGroupEvent extends GroupListEvent {
  final Group newGroup;
  const CreateGroupEvent(this.newGroup);
}

class DeleteGroupEvent extends GroupListEvent {
  final int id;
  const DeleteGroupEvent(this.id);
}
