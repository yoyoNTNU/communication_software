import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:proj/profile_dialog/profile_dialog_api.dart';

part 'profile_dialog_event.dart';
part 'profile_dialog_state.dart';

class ProfileDialogBloc extends Bloc<ProfileDialogEvent, ProfileDialogState> {
  ProfileDialogBloc() : super(const SelfProfile(data: {})) {
    on<OpenProfile>((event, emit) {
      if (event.userID == -1 && event.isGroup == false) {
        // TODO: get self profile data
        emit(const SelfProfile(data: {}));
      } else if (event.userID != -1 && event.isGroup == false) {
        // Open friend profile (or stranger profile)
        Future.wait([
          GetFriendAPI.getCheckFriend(event.userID),
          GetFriendAPI.getFriendInfo(event.userID),
        ]).then((results) {
          final isFriend = results[0]['isFriend'];
          final friendData = results[1];
          emit(FriendProfile(
              data: friendData, friendID: event.userID, isFriend: isFriend));
        });
      } else if (event.groupID != -1 && event.isGroup == true) {
        // TODO: Get group profile data
        emit(GroupProfile(id: event.userID, data: const {}));
      }
    });
  }
}
