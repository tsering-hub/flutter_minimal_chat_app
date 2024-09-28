import 'package:flutter/material.dart';
import 'package:flutter_minimal_chat_app/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // chat service
  final ChatService _chatService = ChatService();

  // textController
  final TextEditingController _messageController = TextEditingController();

  // send method
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          receiverID, _messageController.text.isNotEmpty);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
    );
  }
}
