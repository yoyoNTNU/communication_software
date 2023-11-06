part of 'profile_dialog_bloc.dart';

@immutable
abstract class ProfileDialogState extends Equatable {
  final Map<String, dynamic> data;

  const ProfileDialogState({required this.data});

  @override
  List<Object> get props => [data];
}

final class SelfProfile extends ProfileDialogState {
  const SelfProfile({required Map<String, dynamic> data}) : super(data: data);
}

final class FriendProfile extends ProfileDialogState {
  final int friendID;
  final bool isFriend;
  final bool isInvited;
  final bool isRequested;

  const FriendProfile({
    required Map<String, dynamic> data,
    required this.friendID,
    this.isFriend = false,
    this.isInvited = false,
    this.isRequested = false,
  }) : super(data: data);

  @override
  List<Object> get props => [friendID, data];
}

final class GroupProfile extends ProfileDialogState {
  final int id;

  const GroupProfile({required Map<String, dynamic> data, required this.id})
      : super(data: data);

  @override
  List<Object> get props => [id, data];
}
