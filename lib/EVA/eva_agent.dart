// lib/EVA/eva_agent.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class EVAAgent {
  static const String _url =
      "https://eva-support-bot.onrender.com/webhook/eva-chat";

  /// Sends a user message to EVA and returns the response.
  static Future<String> ask(String userMessage) async {
    if (userMessage.trim().isEmpty) return "Please ask something!";

    try {
      final response = await http
          .post(
            Uri.parse(_url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"message": userMessage}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response']?.toString() ?? "No response from EVA.";
      } else {
        return "Server error: ${response.statusCode}";
      }
    } on TimeoutException {
      return "EVA is taking a nap (free tier). Try again in 10s.";
    } on http.ClientException {
      return "Network issue. Check your connection.";
    } catch (e) {
      return "Error: $e";
    }
  }
}