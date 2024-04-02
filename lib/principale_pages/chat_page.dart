import 'package:flutter/material.dart';

import 'package:memoire/widgets/appbar_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
