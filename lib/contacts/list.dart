import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sentinel/chat/chat_controller.dart';
import 'package:sentinel/models/chat_contact.dart';
import '../chat/chat_screen.dart';
import '../widgets/loader.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Your Chats', style: TextStyle(
                      color: Color(0XFF0F75BC),
                      fontSize: 21,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: StreamBuilder<List<ChatContact>>(
                      stream: ref.watch(chatControllerProvider).chatContacts(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const Loader();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var chatContactData = snapshot.data![index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
                                      'name': chatContactData.name,
                                      'uid': chatContactData.contactId,
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ListTile(
                                      title: Text(
                                        chatContactData.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          chatContactData.lastMessage,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(chatContactData.profilePic),
                                        radius: 30,
                                      ),
                                      trailing: Text(
                                        DateFormat("h:mma").format(chatContactData.timeSent),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(color: Colors.white, indent: 85),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
