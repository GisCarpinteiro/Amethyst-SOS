part of 'group_list_bloc.dart';

sealed class GroupListState extends Equatable {
  final List<Group> groups;

  const GroupListState({required this.groups});

  @override
  List<Object> get props => [];
}

final class GroupListInitial$ extends GroupListState {
  const GroupListInitial$() : super(groups: const []);
}

final class GetGroupList$ extends GroupListState {
  const GetGroupList$({required super.groups});
}
