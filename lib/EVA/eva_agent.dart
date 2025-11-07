// lib/EVA/eva_agent.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class EVAAgent {
  // ← CHANGE ONLY WHEN ngrok DIES
  static const String _url =
      "https://urijah-communionable-defiantly.ngrok-free.dev/webhook/eva-chat";

  static Future<String> ask(
    String userMessage, {
    required String sessionId,
  }) async {
    if (userMessage.trim().isEmpty) return "Say something!";

    final payload = {
      "message": userMessage,
      "sessionId": sessionId,
    };

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode != 200) {
        return "EVA is down (${response.statusCode})";
      }

      final data = jsonDecode(response.body);
      return data["response"]?.toString() ?? "Thinking...";
    } catch (e) {
      return "No internet";
    }
  }
}