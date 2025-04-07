import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Data class representing the connection details needed to join a LiveKit room
/// This includes the server URL and auth token
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

/// An example service for fetching LiveKit authentication tokens
///
/// To use the LiveKit Cloud sandbox (development only)
/// - Enable your sandbox here https://cloud.livekit.io/projects/p_/sandbox/templates/token-server
/// - Create .env file with your LIVEKIT_SANDBOX_ID
///
/// To use a hardcoded token (development only)
/// - Generate a token: https://docs.livekit.io/home/cli/cli-setup/#generate-access-token
/// - Set `hardcodedServerUrl` and `hardcodedToken` below
///
/// To use your own server (production applications)
/// - Add a token endpoint to your server with a LiveKit Server SDK https://docs.livekit.io/home/server/generating-tokens/
/// - Modify or replace this class as needed to connect to your new token server
/// - Rejoice in your new production-ready LiveKit application!
///
/// See https://docs.livekit.io/home/get-started/authentication for more information
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
  static const String productionServerUrl = 'wss://livekit.istemai.com';

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
