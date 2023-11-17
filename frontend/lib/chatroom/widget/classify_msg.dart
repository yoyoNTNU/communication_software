part of 'chatroom_widget.dart';

Widget classifyMsg({
  final String chatroomType = "friend",
  final bool senderIsMe = false,
  final int? messageID,
  final int? senderID,
  final String messageType = "string",
  final bool isReply = false,
  final int? replyMsgID,
  final int? readCount,
  final String content = "",
  final String msgTime = "",
  final void Function()? onLongPressed,
}) {
  switch (messageType) {
    case "string":
      return StringMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        isReply: isReply,
        replyMsgID: replyMsgID,
        readCount: readCount,
        content: content,
        msgTime: msgTime,
        onLongPressed: onLongPressed,
      );
    case "photo":
      return PhotoMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        content: content,
        readCount: readCount,
        msgTime: msgTime,
        onLongPressed: onLongPressed,
      );
    case "video":
      return VideoMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        content: content,
        msgTime: msgTime,
        readCount: readCount,
        onLongPressed: onLongPressed,
      );
    case "voice":
      return VoiceMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        content: content,
        readCount: readCount,
        msgTime: msgTime,
        onLongPressed: onLongPressed,
      );
    case "view":
      return ViewMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        readCount: readCount,
        content: content,
        msgTime: msgTime,
      );
    case "call":
      return CallMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        readCount: readCount,
        content: content,
        msgTime: msgTime,
      );
    case "info":
      return InfoMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        readCount: readCount,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
        msgTime: msgTime,
      );
    case "file":
      return FileMsg(
        chatroomType: chatroomType,
        messageID: messageID,
        senderIsMe: senderIsMe,
        senderID: senderID,
        readCount: readCount,
        content: content,
        msgTime: msgTime,
        onLongPressed: onLongPressed,
      );
    default:
      return const SizedBox();
  }
}
