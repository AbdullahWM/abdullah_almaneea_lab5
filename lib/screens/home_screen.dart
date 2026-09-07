import 'package:abdullah_almaneea_lab5/services/gemini_api.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  static const Color _primary = Color(0xFF4A6CF7);
  static const Color _accent = Color(0xFF7B4AF7);

  ChatUser user1 = ChatUser(id: '1', firstName: 'me');
  ChatUser user2 = ChatUser(id: '2', firstName: 'bot');

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          'Gemini Chat',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [_primary, _accent],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F8FC),
              Color(0xFFE8EBFA),
              Color(0xFFF3EDFB),
            ],
          ),
        ),
        child: DashChat(
          messageOptions: MessageOptions(
            currentUserTextColor: Colors.white,
            textColor: Colors.black87,
            showTime: true,
            timeTextColor: Colors.grey,
            messagePadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            messageDecorationBuilder: (message, previous, next) {
              final isMe = message.user.id == user1.id;
              return BoxDecoration(
                gradient: isMe
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_primary, _accent],
                      )
                    : null,
                color: isMe ? null : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              );
            },
            avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
              return Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [_primary, _accent],
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://media.discordapp.net/attachments/1439320330555363511/1546503931298062436/Google_Gemini_icon_2025.svg.webp?ex=6aa00585&is=6a9eb405&hm=3ced13e5ce192d9328cda525549a192cf274d4c297c4e23f36dca28642789257&=&format=webp",
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          inputOptions: InputOptions(
            alwaysShowSend: true,
            inputDecoration: InputDecoration(
              hintText: 'Ask me anything...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
            ),
            sendButtonBuilder: (onSend) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: GestureDetector(
                onTap: onSend,
                child: Container(
                  height: 46,
                  width: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_primary, _accent],
                    ),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
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
      ),
    );
  }
}