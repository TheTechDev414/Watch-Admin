import 'package:flutter/material.dart';
import 'package:watch_admin/constants/theme.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Messages",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
