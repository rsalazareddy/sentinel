// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentinel/auth/auth_controller.dart';
import 'package:sentinel/chat/chat_repository.dart';
import 'package:sentinel/models/chat_contact.dart';
import 'package:sentinel/models/message.dart';

final chatControllerProvider = Provider(
  (ref) {
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
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(BuildContext context, String text, String recieverUserId) {
    ref.read(userDataAuthProvider).whenData(
      (value) => chatRepository.sendTextMessage(
        context: context, 
        text: text, 
        recieverUserId: recieverUserId, 
        senderUser: value!
        ));
  }
  
}
