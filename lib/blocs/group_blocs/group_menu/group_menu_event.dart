part of 'group_menu_bloc.dart';

sealed class GroupMenuEvent extends Equatable {
  const GroupMenuEvent();

  @override
  List<Object> get props => [];
}

// To detect when comming from Group List -> Create Group
class InitialCreateGroupEvent extends GroupMenuEvent {
  final BuildContext context; // We Need the context for routing with Navigation.PushNamed() func
  final bool isEdition;
  const InitialCreateGroupEvent({required this.context, this.isEdition = false});
}

// To edit a group we need to read the value of the id to change it on the database.
class GetGroupEvent extends GroupMenuEvent {
  final BuildContext context; // We Need the context for routing with Navigation.PushNamed() func
  final Group group;
  const GetGroupEvent({required this.context, required this.group});
}

// To update a group when pressing save from the Group Menu Screen with the new parameters
class UpdateGroupEvent extends GroupMenuEvent {
  final Group group;
  const UpdateGroupEvent({required this.group});
}

// To create a group when pressing the create button after filling the formulary on Group Menu Screen
class CreateGroupEvent extends GroupMenuEvent {
  final Group group;
  const CreateGroupEvent({required this.group});
}
