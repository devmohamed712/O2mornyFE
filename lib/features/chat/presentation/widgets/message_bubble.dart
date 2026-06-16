import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMine;
  final String text;

  const MessageBubble({super.key, required this.isMine, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMine ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMine ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
