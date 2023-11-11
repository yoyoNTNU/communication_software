part of 'profile_dialog_bloc.dart';

@immutable
sealed class ProfileDialogEvent extends Equatable {
  const ProfileDialogEvent();

  @override
  List<Object> get props => [];
}

class OpenProfile extends ProfileDialogEvent {
  final int id;
  final bool isGroup;
  final int groupMemberCount;

  const OpenProfile({
    this.id = -1,
    this.isGroup = false,
    this.groupMemberCount = 0,
  });

  @override
  List<Object> get props => [id];
}

class ResetProfile extends ProfileDialogEvent {
  @override
  List<Object> get props => [];
}
