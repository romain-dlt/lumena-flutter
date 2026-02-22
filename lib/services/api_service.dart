import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class APIService {
  static String _generateSignature(String timestamp, String body) {
    final String kAPIKey = dotenv.env['LUMENA_API_KEY'] ?? '';

    final payload = '$timestamp.$body';
    final key = utf8.encode(kAPIKey);
    final bytes = utf8.encode(payload);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);

    return digest.toString();
  }

  static Future<String?> editImage({
    required String base64Image,
    required String prompt,
    required String mimeType,
    VoidCallback? onError,
  }) async {
    final String kBaseURL = dotenv.env['LUMENA_API_BASE_URL'] ?? '';

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final body = jsonEncode({
      "image": base64Image,
      "prompt": prompt,
      "mimeType": mimeType,
    });

    final signature = _generateSignature(timestamp, body);

    final response = await http.post(
      Uri.parse("$kBaseURL/edit-image"),
      headers: {
        "Content-Type": "application/json",
        "x-api-signature": signature,
        "x-api-timestamp": timestamp,
      },
      body: body,
    );

    if (response.statusCode != 200 || response.body.isEmpty) {
      if (onError != null) {
        onError();
      }

      return null;
    }

    final json = jsonDecode(response.body);

    return json['image'];
  }
}
