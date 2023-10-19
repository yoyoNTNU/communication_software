part of 'chatroom_widget.dart';

Widget classifyMsg({
  final String chatroomType = "friend",
  final bool senderIsMe = false,
  final int? senderID,
  final String messageType = "string",
  final bool isReply = false,
  final int? replyMsgID,
  final String content = "",
  final String msgTime = "",
  final void Function()? onLongPressed,
}) {
  switch (messageType) {
    case "string":
      return StringMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
        onLongPressed: onLongPressed,
      );
    case "photo":
      return PhotoMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "video":
      return VideoMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "voice":
      return VoiceMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "view":
      return ViewMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "call":
      return CallMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "info":
      return InfoMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "file":
      return FileMsg(
        chatroomType: chatroomType,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    default:
      return const SizedBox();
  }
}
