import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('ErrorCompact Widget Tests', () {
    testWidgets('renders error message correctly', (WidgetTester tester) async {
      const errorMessage = 'Test error message';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorCompact(error: errorMessage),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('shows retry button when onRetry is provided', (WidgetTester tester) async {
      bool retryPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorCompact(
              error: 'Test error',
              onRetry: () => retryPressed = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.refresh));
      expect(retryPressed, isTrue);
    });

    testWidgets('does not show retry button when onRetry is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorCompact(error: 'Test error'),
          ),
        ),
      );

      expect(find.byIcon(Icons.refresh), findsNothing);
    });

    testWidgets('shows custom button text in tooltip', (WidgetTester tester) async {
      const customButtonText = 'Try Again';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorCompact(
              error: 'Test error',
              onRetry: () {},
              buttonText: customButtonText,
            ),
          ),
        ),
      );

      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton, findsOneWidget);
      
      await tester.longPress(refreshButton);
      await tester.pump();
      
      expect(find.text(customButtonText), findsOneWidget);
    });

    testWidgets('fits in constrained space without overflow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 60,
              child: ErrorCompact(
                error: 'This is a very long error message that should be truncated properly',
                onRetry: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ErrorCompact), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    group('Accessibility', () {
      testWidgets('has proper tooltip for retry button', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorCompact(
                error: 'Error message',
                onRetry: () {},
              ),
            ),
          ),
        );

        final iconButton = find.byType(IconButton);
        expect(iconButton, findsOneWidget);
        
        final iconButtonWidget = tester.widget<IconButton>(iconButton);
        expect(iconButtonWidget.tooltip, equals('Reintentar'));
      });

      testWidgets('uses custom tooltip when buttonText is provided', (WidgetTester tester) async {
        const customText = 'Retry Action';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorCompact(
                error: 'Error message',
                onRetry: () {},
                buttonText: customText,
              ),
            ),
          ),
        );

        final iconButtonWidget = tester.widget<IconButton>(find.byType(IconButton));
        expect(iconButtonWidget.tooltip, equals(customText));
      });
    });
  });
}