class ChatMessage {
  final String messageId;
  final String threadId;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime sentAt;
  final bool isMe;

  const ChatMessage({
    required this.messageId,
    required this.threadId,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.sentAt,
    this.isMe = false,
  });
}
