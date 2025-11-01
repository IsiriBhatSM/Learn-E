// lib/EVA/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:learn_e/EVA/eva_agent.dart';

class ChatScreen extends StatefulWidget {
  final VoidCallback onClose;

  const ChatScreen({super.key, required this.onClose});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Welcome message
    _addMessage("Hello! I'm EVA, your learning assistant. How can I help?", isBot: true);
  }

  void _addMessage(String text, {required bool isBot}) {
    setState(() {
      _messages.add(ChatMessage(text: text, isBot: isBot));
    });
  }

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    _addMessage(userMessage, isBot: false);
    _controller.clear();
    setState(() => _isLoading = true);

    final response = await EVAAgent.ask(userMessage);
    _addMessage(response, isBot: true);
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // ── Header ──────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "EVA Assistant",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: widget.onClose,
              ),
            ],
          ),
        ),

        // ── Messages ────────────────────────────────────
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (_isLoading && index == _messages.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final message = _messages[index];
              return ChatBubble(
                message: message,
                isDark: isDark,
                primaryColor: theme.primaryColor,
              );
            },
          ),
        ),

        // ── Input ───────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.grey[100],
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Ask EVA anything...",
                    hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.grey[800] : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: theme.primaryColor,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Chat Message Model
// ──────────────────────────────────────────────────────────────
class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
}

// ──────────────────────────────────────────────────────────────
// Chat Bubble Widget
// ──────────────────────────────────────────────────────────────
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDark;
  final Color primaryColor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    final bubbleColor = isBot
        ? (isDark ? Colors.grey[700] : Colors.grey[200])
        : primaryColor;
    final textColor = isBot
        ? (isDark ? Colors.white70 : Colors.black87)
        : Colors.white;

    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}