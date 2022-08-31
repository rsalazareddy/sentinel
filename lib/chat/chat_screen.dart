import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentinel/auth/auth_controller.dart';
import 'package:sentinel/chat/chat_list.dart';
import 'package:sentinel/chat/widgets/bottom_chat_field.dart';
import 'package:sentinel/models/user.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(snapshot.data!.isOnline ? 'Online' : 'Offline', textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal
                  ),)
                ],
              );
          }
          ),
          centerTitle: false,
          toolbarHeight: 60,
          bottom: PreferredSize(
            child: Container(height: 10),
            preferredSize: Size.fromHeight(20)
          ),
      ),
      body: Column(
        children: [
          Expanded(child: ChatList(recieverUserId: uid)),
          BottomChatField(
            receiverUserId: uid,
          ),
        ],
      ),
    );
  }
}
