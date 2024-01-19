import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/models/message.dart';

import '../../../info.dart';
import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerWidget {
  final String recieverUserId;
  const ChatList({
    super.key,
    required this.recieverUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).chatStream(recieverUserId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
               var timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId == FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
              );
            },
          );
        });
  }
}
