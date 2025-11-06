// lib/EVA/chat_screen.dart
import 'package:flutter/material.dart';
import 'eva_agent.dart';

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

  // One brain per chat window
  final String _sessionId = "user-${DateTime.now().millisecondsSinceEpoch}";

  @override
  void initState() {
    super.initState();
    _addMessage("Hey there! I'm EVA, your personal assistant. What's up?", isBot: true);
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

    // Get raw JSON from n8n
    final raw = await EVAAgent.ask(userMessage, sessionId: _sessionId);

    // MAGIC: Remove {response: ...} → clean English
    String cleanReply = raw
        .replaceAll(RegExp(r'^\{response:\s*'), '')
        .replaceAll(RegExp(r'\}$'), '')
        .trim();

    _addMessage(cleanReply, isBot: true);
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
        // ── Sleek Header ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFC603F),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(Icons.smart_toy, size: 18, color: Color(0xFFFC603F)),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "EVA Assistant",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 26),
                onPressed: widget.onClose,
              ),
            ],
          ),
        ),

        // ── Chat Bubbles ──
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (_isLoading && index == _messages.length) {
                return _buildTypingDots();
              }
              final message = _messages[index];
              return ChatBubble(message: message, isDark: isDark);
            },
          ),
        ),

        // ── Input Bar ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.grey[50],
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            border: const Border(top: BorderSide(color: Colors.grey)),          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Ask EVA anything...",
                    hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.grey[800] : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                mini: true,
                backgroundColor: const Color(0xFFFC603F),
                elevation: 4,
                onPressed: _isLoading ? null : _sendMessage,
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Typing dots animation
  Widget _buildTypingDots() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dot(),
            SizedBox(width: 4),
            Dot(delay: 0.2),
            SizedBox(width: 4),
            Dot(delay: 0.4),
          ],
        ),
      ),
    );
  }
}

// ── Message Model ──
class ChatMessage {
  final String text;
  final bool isBot;
  ChatMessage({required this.text, required this.isBot});
}

// ── Beautiful Bubbles ──
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDark;
  const ChatBubble({super.key, required this.message, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isBot
              ? (isDark ? Colors.grey[700] : Colors.grey[200])
              : const Color(0xFFFC603F),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isBot
                ? (isDark ? Colors.white70 : Colors.black87)
                : Colors.white,
            fontSize: 16,
            height: 1.4,
            fontWeight: isBot ? FontWeight.normal : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ── Typing Dot Animation ──
class Dot extends StatefulWidget {
  final double delay;
  const Dot({super.key, this.delay = 0});
  @override State<Dot> createState() => _DotState();
}
class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat();
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) _controller.repeat();
    });
  }
  @override void dispose() { _controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey)),
    );
  }
}