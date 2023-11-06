part of 'profile_dialog_bloc.dart';

@immutable
sealed class ProfileDialogEvent extends Equatable {
  const ProfileDialogEvent();

  @override
  List<Object> get props => [];
}

class OpenProfile extends ProfileDialogEvent {
  final int userID;
  final int groupID;
  final bool isGroup;

  const OpenProfile({
    this.userID = -1,
    this.groupID = -1,
    this.isGroup = false,
  });

  @override
  List<Object> get props => [userID];
}

class ResetProfile extends ProfileDialogEvent {
  @override
  List<Object> get props => [];
}
