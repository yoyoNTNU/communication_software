part of 'chatroom_widget.dart';

Widget classifyMsg({
  final bool senderIsMe = false,
  final int? senderID,
  final String messageType = "string",
  final bool isReply = false,
  final int? replyMsgID,
  final String content = "",
}) {
  switch (messageType) {
    case "string":
      return StringMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "photo":
      return PhotoMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "video":
      return VideoMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "voice":
      return VoiceMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "view":
      return ViewMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "call":
      return CallMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "info":
      return InfoMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    case "file":
      return FileMsg(
        senderIsMe: senderIsMe,
        senderID: senderID,
        messageType: messageType,
        isReply: isReply,
        replyMsgID: replyMsgID,
        content: content,
      );
    default:
      return const SizedBox();
  }
}
