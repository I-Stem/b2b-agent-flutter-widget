import 'package:b2b_agent_flutter_widget/services/token_service.dart';
import 'package:b2b_agent_flutter_widget/widgets/control_bar.dart';
import 'package:b2b_agent_flutter_widget/widgets/status.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_components/livekit_components.dart' hide ControlBar;
import 'package:provider/provider.dart';

class B2BAgentFlutterWidget extends StatefulWidget {
  final String participantId;
  final String companyId;
  final String agentId;
  final String agentServiceKey;

  const B2BAgentFlutterWidget({
    super.key,
    required this.participantId,
    required this.companyId,
    required this.agentId,
    required this.agentServiceKey,
  });

  @override
  State<B2BAgentFlutterWidget> createState() => _B2BAgentFlutterWidgetState();
}

class _B2BAgentFlutterWidgetState extends State<B2BAgentFlutterWidget> {
  final room = Room(roomOptions: const RoomOptions(enableVisualizer: true));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => TokenService(
                participantId: widget.participantId,
                companyId: widget.companyId,
                agentId: widget.agentId,
                agentServiceKey: widget.agentServiceKey,
              ),
        ),
        ChangeNotifierProvider(create: (context) => RoomContext(room: room)),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 256,
                minHeight: 128,
                maxHeight: 128,
              ),
              child: const StatusWidget(),
            ),
            const ControlBar(),
          ],
        ),
      ),
    );
  }
}
