import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('User'),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('My Profile'))),
    );
  }
}
