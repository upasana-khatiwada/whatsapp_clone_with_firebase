import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';

import '../../../models/message.dart';
import '../repositories/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
            //isGroupChat: isGroupChat,
          ),
        );
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value!,
            messageEnum: messageEnum,
            //isGroupChat: isGroupChat,
            ref: ref,
          ),
        );
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
  ) {
    //for this url we are converting it into
    //https://giphy.com/gifs/TheSwoon-PQ0VI3S5vqL5pwQQJX
    //this
    //https://i.giphy.com/media/PQ0VI3S5vqL5pwQQJX/200.gif
    int gifUrlPartIndex =
        gifUrl.lastIndexOf('-') + 1; // part after this PQ0VI3S5vqL5pwQQJX
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
            context: context,
            gifUrl: newgifUrl,
            recieverUserId: recieverUserId,
            senderUser: value!,
          ),
        );
  }
}
