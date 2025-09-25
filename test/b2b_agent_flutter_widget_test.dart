import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:b2b_agent_flutter_widget/b2b_agent_flutter_widget.dart';

void main() {
  testWidgets('B2B Agent Flutter Widget displays text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: B2BAgentFlutterWidget(
            participantId: 'test',
            agentId: 'test',
            publicKey: 'test',
          ),
        ),
      ),
    );
    // The control bar should render a connect button by default
    expect(find.text('START A CONVERSATION'), findsOneWidget);
  });
}
