import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(15),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
