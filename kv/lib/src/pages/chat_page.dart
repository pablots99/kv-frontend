import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Chat'),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('Chats'))),
    );
  }
}
