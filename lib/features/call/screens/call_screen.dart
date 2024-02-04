import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/config/agora_config.dart';
import 'package:whatsapp_clone/models/call.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;
  const CallScreen({
    super.key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  AgoraClient? client;
  //for the heroku we need payment so from 9:55 watch to connect server just using example
  String baseUrl = 'https://whatsapp-clone-upasana.herokuapp.com';
  @override
  void initState() {
    super.initState();
    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
      appId: AgoraConfig.appId,
      channelName: widget.channelId,
      tokenUrl: baseUrl,
    ));
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : SafeArea(
              child: Stack(
              children: [
                AgoraVideoViewer(client: client!),
                AgoraVideoButtons(
                  client: client!,
                  disconnectButtonChild: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call_end),
                  ),
                )
              ],
            )),
    );
  }
}