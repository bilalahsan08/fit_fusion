// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class GooglleApiService {
  static String apiKey = ApiContant.apiKey;
  static String baseUrl = ApiContant.baseUrl;

  static Future<String> getApiResponse(String message) async {
    try {
      final systemPrompt = '''
You are FitFusion’s AI assistant.
If someone asks "Who is the founder of FitFusion?", reply with "FitFusion is a FYP 2025\n Presented by \nAsad Farooq Khan\\nBilal Ahsan\\nFarhan Zafar."
If someone asks "how to contact support", reply with "Please contact us at support@fitfusion.com."
Otherwise, answer as a fitness chatbot. Don't answer if it is not related to any health issue or fitness.
''';

      final response = await http.post(
        Uri.parse("$baseUrl$apiKey"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": systemPrompt}
              ]
            },
            {
              "role": "user",
              "parts": [
                {"text": message}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey("candidates") && data["candidates"].isNotEmpty) {
          var firstCandidate = data["candidates"][0];

          if (firstCandidate.containsKey("content") &&
              firstCandidate["content"].containsKey("parts") &&
              firstCandidate["content"]["parts"].isNotEmpty) {
            return firstCandidate["content"]["parts"][0]["text"] ??
                "AI response was empty.";
          }
        }
        return "AI did not return any content.";
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      print("Error=> $e");
      return "Error: $e";
    }
  }
}
