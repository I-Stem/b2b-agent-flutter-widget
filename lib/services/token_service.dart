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
  final String companyId;
  final String agentId;
  final String agentServiceKey;

  TokenService({
    required this.participantId,
    required this.companyId,
    required this.agentId,
    required this.agentServiceKey,
  });

  // Production LiveKit server URL
  static const String productionServerUrl =
      'wss://samora-prod-up2gn0dr.livekit.cloud';

  // Production token endpoint
  static const String tokenEndpoint =
      'https://api.samora.ai/agent/token/inbound';

  /// Main method to get connection details
  /// First tries hardcoded credentials, then falls back to sandbox
  Future<ConnectionDetails?> fetchConnectionDetails() async {
    final uri = Uri.parse('$tokenEndpoint/$companyId/$agentId/$participantId');

    try {
      final response = await http.get(
        uri,
        headers: {'X-Agent-Service-Key': agentServiceKey},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final data = jsonDecode(response.body);
          return ConnectionDetails(
            serverUrl: productionServerUrl,
            participantToken: data['token'],
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
