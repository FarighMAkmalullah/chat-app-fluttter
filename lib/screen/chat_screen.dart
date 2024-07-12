import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/service/chat/chat_service.dart';
import 'package:chat_application/widget/my_textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String email;
  final String receiverID;
  ChatScreen({
    super.key,
    required this.email,
    required this.receiverID,
  });

  // buat text controll
  final TextEditingController _messageController = TextEditingController();

  // chat dan auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // mengirimkam pesan
  void sendMessege() async {
    if (_messageController.text.isNotEmpty) {
      // Kirim Pesan
      await _chatService.sendMessege(
        receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
      ),
      body: Column(
        children: [
          // Menampilkan pesan

          Expanded(
            child: _buildMessageList(),
          ),

          // Menampilkan Input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build list pesan
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(receiverID, senderID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // menampilkan pesan
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["message"]),
          ],
        ));
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextFieldWidget(
            hintText: 'Type a message',
            obscureText: false,
            controller: _messageController,
          ),
        ),
        IconButton(onPressed: sendMessege, icon: Icon(Icons.send))
      ],
    );
  }
}
