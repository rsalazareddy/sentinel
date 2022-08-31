import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentinel/models/message.dart';
import 'package:sentinel/models/user.dart';
import 'package:sentinel/utils/enums/message_enum.dart';
import 'package:sentinel/utils/utils.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_contact.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
  firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('chats')
      .snapshots().asyncMap((event) async {
        List<ChatContact> contacts = [];
        for(var document in event.docs) {
          var chatContact = ChatContact.fromMap(document.data());
          var userData = await firestore.collection('users').doc(chatContact.contactId).get();
          var user = UserModel.fromMap(userData.data()!);

          contacts.add(ChatContact(
          name: user.name, 
          profilePic: user.profilePic, 
          contactId: user.uid, 
          timeSent: chatContact.timeSent, 
          lastMessage: chatContact.lastMessage)
          );
        }
        return contacts;
      });
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return firestore.collection('users')
    .doc(auth.currentUser!.uid)
    .collection('chats')
    .doc(recieverUserId)
    .collection('messages')
    .orderBy('timeSent')
    .snapshots().map((event) {
      List<Message> messages = [];
      for(var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  void _saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    var receiverChatContact = ChatContact(
      name: senderUserData.name, 
      profilePic: senderUserData.profilePic, 
      contactId: senderUserData.uid, 
      timeSent: timeSent, 
      lastMessage: text
      );

      await firestore
      .collection('users')
      .doc(receiverUserId)
      .collection('chats')
      .doc(auth.currentUser!.uid)
      .set(receiverChatContact.toMap());

      var senderChatContact = ChatContact(
      name: recieverUserData.name, 
      profilePic: recieverUserData.profilePic, 
      contactId: recieverUserData.uid, 
      timeSent: timeSent, 
      lastMessage: text
      );
      
      await firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('chats')
      .doc(receiverUserId)
      .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubCollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required recieverUserName,
    required MessageEnum messageType,
    }) async {
      final message = Message(
        senderId: auth.currentUser!.uid, 
        receiverId: receiverUserId, 
        text: text, 
        type: messageType, 
        timeSent: timeSent, 
        messageId: messageId, 
        isSeen: false,
        );

        await firestore.
        collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

        await firestore.
        collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,

  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;
      var userDataMap = await firestore.collection('users').doc(recieverUserId).get();

      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();

      _saveDataToContactsSubCollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubCollection(
        receiverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        recieverUserName: recieverUserData.name,
        username: senderUser.name
      );

    } catch(e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
