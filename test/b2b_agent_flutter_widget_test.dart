import 'package:flutter_test/flutter_test.dart';

import 'package:b2b_agent_flutter_widget/b2b_agent_flutter_widget.dart';

void main() {
  testWidgets('B2B Agent Flutter Widget displays text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      // This is a fake test to avoid the error
      const B2BAgentFlutterWidget(
        participantId: 'test',
        companyId: 'test',
        agentId: 'test',
        agentServiceKey: 'test',
      ),
    );
    expect(find.text('Hello, from B2B Agent Flutter Widget!'), findsOneWidget);
  });
}
