import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:proj/profile_dialog/profile_dialog_api.dart';
import 'package:proj/data.dart';

part 'profile_dialog_event.dart';
part 'profile_dialog_state.dart';

class ProfileDialogBloc extends Bloc<ProfileDialogEvent, ProfileDialogState> {
  ProfileDialogBloc() : super(const SelfProfile(data: {})) {
    on<ResetProfile>((event, emit) async {
      emit(const NoProfile(data: {}));
    });
    on<OpenProfile>((event, emit) async {
      final dbToken = await DatabaseHelper.instance.getToken();
      final id = dbToken?.userID;
      if ((event.id == id || event.id == -1) && event.isGroup == false) {
        Map<String, dynamic> info = await GetFriendAPI.getSelfInfo();
        emit(SelfProfile(data: info));
      } else if (event.id != id && event.isGroup == false) {
        String check = await GetFriendAPI.getCheckFriend(event.id);
        Map<String, dynamic> info = await GetFriendAPI.getFriendInfo(event.id);
        emit(FriendProfile(
          data: info,
          friendID: event.id,
          isFriend: check == 'Friend',
          isReceiver: check == 'Receiver',
          isSender: check == 'Sender',
        ));
      } else if (event.id != -1 && event.isGroup == true) {
        Map<String, dynamic> info = await GetGroupAPI.getGroupInfo(event.id);
        emit(GroupProfile(data: info, memberCount: event.groupMemberCount));
      }
    });
  }
}
