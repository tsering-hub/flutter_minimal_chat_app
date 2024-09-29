import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minimal_chat_app/components/chat_bubble.dart';
import 'package:flutter_minimal_chat_app/components/my_textfield.dart';
import 'package:flutter_minimal_chat_app/services/auth/auth_service.dart';
import 'package:flutter_minimal_chat_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // chat service
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // textController
  final TextEditingController _messageController = TextEditingController();

  // send method
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
      _messageController.clear();

      scrollDown();
    }
  }

  // for textfeild focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // add listener to focusnode
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    myFocusNode.dispose();
    _messageController.dispose();

    super.dispose();
  }

  // scroll controller
  ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputTextField(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(widget.receiverID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading..");
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  Widget _buildInputTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              focusNode: myFocusNode,
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
