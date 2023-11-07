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
      if ((event.userID == id || event.userID == -1) &&
          event.isGroup == false) {
        Map<String, dynamic> info = await GetFriendAPI.getSelfInfo();
        emit(SelfProfile(data: info));
      } else if (event.userID != id && event.isGroup == false) {
        String check = await GetFriendAPI.getCheckFriend(event.userID);
        Map<String, dynamic> info =
            await GetFriendAPI.getFriendInfo(event.userID);
        emit(FriendProfile(
          data: info,
          friendID: event.userID,
          isFriend: check == 'Friend',
          isReceiver: check == 'Receiver',
          isSender: check == 'Sender',
        ));
      } else if (event.groupID != -1 && event.isGroup == true) {
        // TODO: Get group profile data
        emit(GroupProfile(id: event.userID, data: const {}));
      }
    });
  }
}
