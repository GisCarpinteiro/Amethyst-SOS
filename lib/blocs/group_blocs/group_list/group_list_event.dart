part of 'group_list_bloc.dart';

sealed class GroupListEvent extends Equatable {
  const GroupListEvent();

  @override
  List<Object> get props => [];
}

class GetGroupsListEvent extends GroupListEvent {
  const GetGroupsListEvent();
}

class CreateGroupEvent extends GroupListEvent {
  final Group newGroup;
  const CreateGroupEvent(this.newGroup);
}

class DeleteGroupEvent extends GroupListEvent {
  final int id;
  const DeleteGroupEvent(this.id);
}
