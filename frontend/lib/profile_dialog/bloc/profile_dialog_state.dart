part of 'profile_dialog_bloc.dart';

@immutable
abstract class ProfileDialogState extends Equatable {
  final Map<String, dynamic> data;

  const ProfileDialogState({required this.data});

  @override
  List<Object> get props => [data];
}

final class NoProfile extends ProfileDialogState {
  const NoProfile({required Map<String, dynamic> data}) : super(data: data);
}

final class SelfProfile extends ProfileDialogState {
  const SelfProfile({required Map<String, dynamic> data}) : super(data: data);
}

final class FriendProfile extends ProfileDialogState {
  final int friendID;
  final bool isFriend;
  final bool isReceiver;
  final bool isSender;

  const FriendProfile({
    required Map<String, dynamic> data,
    required this.friendID,
    this.isFriend = false,
    this.isReceiver = false,
    this.isSender = false,
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
