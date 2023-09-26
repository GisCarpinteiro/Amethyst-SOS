part of 'group_menu_bloc.dart';

sealed class GroupMenuState extends Equatable {
  final bool isGroupEditionContext;
  final Group group;

  const GroupMenuState({this.isGroupEditionContext = false, this.group = const Group(name: "", contacts: [])});

  @override
  List<Object> get props => [];
}

final class GroupMenuInitial$ extends GroupMenuState {
  const GroupMenuInitial$({super.isGroupEditionContext = false, super.group = const Group(name: "", contacts: [])});
}

// The initial state used to create a group, doesn't needs info.
final class SetGroupCreationContext$ extends GroupMenuState {
  const SetGroupCreationContext$({super.isGroupEditionContext = false, super.group = const Group(name: "", contacts: [])});
}

// The State used to edit a group, requires an the EdtionContext set to true.
final class EditGroup$ extends GroupMenuState {
  const EditGroup$({required super.group, super.isGroupEditionContext = true});
}
