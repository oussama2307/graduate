// individual_chat_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';
import 'package:memoire/providers/chat_provider.dart';

class IndividualChatPage extends StatelessWidget {
  final String otherUserName;

  IndividualChatPage({Key? key, required this.otherUserName}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<UsernameProvider>(context, listen: false).user['name'];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: greenColor,
          title: Text(
            otherUserName,
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  final messages =
                      chatProvider.getMessages(currentUser, otherUserName);
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      return _buildMessageBubble(message, currentUser);
                    },
                  );
                },
              ),
            ),
            _buildMessageInput(context, currentUser),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message, String currentUser) {
    final isCurrentUser = message.sender == currentUser;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.roboto(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context, String currentUser) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: S.of(context).message,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(context, currentUser),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, String currentUser) {
    if (_messageController.text.isNotEmpty) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.addMessage(
        Message(
          sender: currentUser,
          recipient: otherUserName,
          text: _messageController.text,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    }
  }
}
