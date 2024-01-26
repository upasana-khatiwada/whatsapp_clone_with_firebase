import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

//whenever we click or slide this this message reply will get updated so this message reply 
//provider will get the value with the message 
final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);