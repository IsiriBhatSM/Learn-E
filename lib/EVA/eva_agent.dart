import 'dart:convert';
import 'dart:async';  // ← ADD THIS LINE
import 'package:http/http.dart' as http;

class EVAAgent {
  static const String _url = "https://urijah-communionable-defiantly.ngrok-free.dev/webhook/eva";

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
      return "EVA is taking a moment, please wait!";
    } on http.ClientException {
      return "Network issue. Check your connection.";
    } catch (e) {
      return "Error: $e";
    }
  }
} 