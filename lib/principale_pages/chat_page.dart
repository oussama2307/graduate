import 'package:flutter/material.dart';
import 'package:memoire/principale_pages/sending_page.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:memoire/providers/chat_provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<UsernameProvider>(context, listen: false).user['name'];

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          final users = chatProvider.getUniqueUsers(currentUser);

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final otherUser = users[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(otherUser[0].toUpperCase()),
                  ),
                  title: Text(otherUser),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IndividualChatPage(otherUserName: otherUser),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
