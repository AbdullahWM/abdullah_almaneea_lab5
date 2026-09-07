import 'package:abdullah_almaneea_lab5/services/gemini_api.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  ChatUser user1 = ChatUser(id: '1', firstName: 'me');
  ChatUser user2 = ChatUser(id: '2', firstName: 'bot');

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text('Gemini Chat'),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A6CF7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          currentUserContainerColor: const Color(0xFF4A6CF7),
          currentUserTextColor: Colors.white,
          containerColor: const Color(0xFFEDEFF5),
          textColor: Colors.black,
          borderRadius: 16,
          showTime: true,
          timeTextColor: Colors.grey,
          avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
            return Image.network(
              "https://media.discordapp.net/attachments/1439320330555363511/1546480149086609409/claude.png?ex=6a9fef5f&is=6a9e9ddf&hm=9c166df12bcd6acf4a931c72518999da71363062df91d78af682dd2a311bf25a&=&format=webp&quality=lossless",
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            );
          },
        ),
        currentUser: user1,
        onSend: (messages) async {
          messagesList.insert(0, messages);
          setState(() {});

          String botMessage = await GeminiApi().sendRequest(messages.text);
          ChatMessage reply = ChatMessage(
            user: user2,
            createdAt: DateTime.now(),
            text: botMessage,
          );
          messagesList.insert(0, reply);
          setState(() {});
        },
        messages: messagesList,
      ),
    );
  }
}
