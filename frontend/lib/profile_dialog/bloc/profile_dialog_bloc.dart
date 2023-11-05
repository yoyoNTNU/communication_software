import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:proj/profile_dialog/profile_dialog_api.dart';

part 'profile_dialog_event.dart';
part 'profile_dialog_state.dart';

class ProfileDialogBloc extends Bloc<ProfileDialogEvent, ProfileDialogState> {
  ProfileDialogBloc() : super(const SelfProfile(data: {})) {
    on<ResetProfile>((event, emit) async {
      emit(const SelfProfile(data: {}));
    });
    on<OpenProfile>((event, emit) async {
      if (event.userID == -1 && event.isGroup == false) {
        // TODO: get self profile data
        emit(const SelfProfile(data: {}));
      } else if (event.userID != -1 && event.isGroup == false) {
        String check = await GetFriendAPI.getCheckFriend(event.userID);
        Map<String, dynamic> info =
            await GetFriendAPI.getFriendInfo(event.userID);
        emit(FriendProfile(
          data: info,
          friendID: event.userID,
          isFriend: check == 'Friend',
          isInvited: check == 'Receiver',
          isRequested: check == 'Sender',
        ));
      } else if (event.groupID != -1 && event.isGroup == true) {
        // TODO: Get group profile data
        emit(GroupProfile(id: event.userID, data: const {}));
      }
    });
  }
}
