import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ConnectionDetails {
  final String serverUrl;
  final String participantToken;

  ConnectionDetails({required this.serverUrl, required this.participantToken});

  factory ConnectionDetails.fromJson(Map<String, dynamic> json) {
    return ConnectionDetails(
      serverUrl: json['serverUrl'],
      participantToken: json['participantToken'],
    );
  }
}

class TokenService extends ChangeNotifier {
  final String participantId;
  final String agentId;
  final String publicKey;

  TokenService({
    required this.participantId,
    required this.agentId,
    required this.publicKey,
  });

  // Production LiveKit server URL
  static const String productionServerUrl =
      'wss://samora-prod-up2gn0dr.livekit.cloud';

  // Production token endpoint
  static const String tokenEndpoint =
      'https://api.samora.ai/v1/livekit/widget-token';

  /// Main method to get connection details
  /// First tries hardcoded credentials, then falls back to sandbox
  Future<ConnectionDetails?> fetchConnectionDetails() async {
    final uri = Uri.parse('$tokenEndpoint/$agentId/$participantId/app');

    try {
      final response = await http.get(
        uri,
        headers: {'X-Org-Public-Key': publicKey},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final data = jsonDecode(response.body);
          return ConnectionDetails(
            serverUrl: productionServerUrl,
            participantToken: data['data']['token'],
          );
        } catch (e) {
          debugPrint(
            'Error parsing connection details from production server, response: ${response.body}',
          );
          return null;
        }
      } else {
        debugPrint(
          'Error from production server: ${response.statusCode}, response: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('Failed to connect to production server: $e');
      return null;
    }
  }
}
