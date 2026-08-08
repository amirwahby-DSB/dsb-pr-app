import 'chat_strings.dart';
import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final String threadId;
  const ChatScreen({super.key, required this.threadId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<ChatMessage> _messages;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = MockDataService.instance.getMessagesForThread(widget.threadId);
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        messageId: 'm${_messages.length + 1}',
        threadId: widget.threadId,
        senderId: MockDataService.instance.currentUser.userId,
        senderName: 'أنتِ',
        text: text,
        sentAt: DateTime.now(),
        isMe: true,
      ));
      // TODO: push message to backend / websocket channel scoped to threadId
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.threadId == 'general_pr_office'
    ? ChatStrings.generalOfficeTitle
    : ChatStrings.threadTitle(widget.threadId)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _MessageBubble(message: _messages[i]),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: DSBAColors.textMuted),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: ChatStrings.messageHint,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 6),
                  CircleAvatar(
                    backgroundColor: DSBAColors.primaryCrimson,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: _send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        decoration: BoxDecoration(
          color: isMe ? DSBAColors.primaryCrimson : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isMe ? null : Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(message.senderName,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: DSBAColors.primaryCrimson)),
            if (!isMe) const SizedBox(height: 3),
            Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : DSBAColors.neutralDark, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              '${message.sentAt.hour.toString().padLeft(2, '0')}:${message.sentAt.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 9,
                color: isMe ? Colors.white70 : DSBAColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
