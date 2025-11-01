// lib/EVA/floating_eva_button.dart
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class FloatingEVAButton extends StatefulWidget {
  const FloatingEVAButton({super.key});

  @override
  State<FloatingEVAButton> createState() => _FloatingEVAButtonState();
}

class _FloatingEVAButtonState extends State<FloatingEVAButton> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleChat() {
    if (_overlayEntry != null) {
      // Close chat
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {});
    } else {
      // Open chat as TRUE OVERLAY
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          bottom: 80,
          left: 16,
          right: 16,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 520,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ChatScreen(
                onClose: () {
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      );
      
      Overlay.of(context).insert(_overlayEntry!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleChat,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFFFC603F),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _overlayEntry != null ? Icons.close : Icons.support_agent,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}