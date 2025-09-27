import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('ErrorInline Widget Tests', () {
    testWidgets('renders error message with default icon', (WidgetTester tester) async {
      const errorMessage = 'Inline error message';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(error: errorMessage),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('shows custom title and icon', (WidgetTester tester) async {
      const customTitle = 'Custom Error Title';
      const customIcon = Icons.cloud_off;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(
              error: 'Test error',
              title: customTitle,
              icon: customIcon,
            ),
          ),
        ),
      );

      expect(find.text(customTitle), findsOneWidget);
      expect(find.byIcon(customIcon), findsOneWidget);
    });

    testWidgets('shows retry button when enabled and onRetry provided', (WidgetTester tester) async {
      bool retryPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(
              error: 'Test error',
              showRetryButton: true,
              onRetry: () => retryPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Reintentar'), findsOneWidget);
      
      await tester.tap(find.text('Reintentar'));
      expect(retryPressed, isTrue);
    });

    testWidgets('hides retry button when showRetryButton is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(
              error: 'Test error',
              showRetryButton: false,
              onRetry: () {},
            ),
          ),
        ),
      );

      expect(find.text('Reintentar'), findsNothing);
    });

    testWidgets('hides retry button when onRetry is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(
              error: 'Test error',
              showRetryButton: true,
              onRetry: null,
            ),
          ),
        ),
      );

      expect(find.text('Reintentar'), findsNothing);
    });

    testWidgets('shows custom button text', (WidgetTester tester) async {
      const customButtonText = 'Try Again';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorInline(
              error: 'Test error',
              buttonText: customButtonText,
              onRetry: () {},
            ),
          ),
        ),
      );

      expect(find.text(customButtonText), findsOneWidget);
    });

    group('Layout and Styling', () {
      testWidgets('uses custom padding when provided', (WidgetTester tester) async {
        const customPadding = EdgeInsets.all(32.0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorInline(
                error: 'Test error',
                padding: customPadding,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, equals(customPadding));
      });

      testWidgets('uses default padding when none provided', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorInline(error: 'Test error'),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, equals(const EdgeInsets.all(16.0)));
      });

      testWidgets('error message is scrollable for long text', (WidgetTester tester) async {
        final longErrorMessage = 'This is a very long error message that should be scrollable when it exceeds the available space. ' * 10;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 200, // Constrain height
                child: ErrorInline(error: longErrorMessage),
              ),
            ),
          ),
        );

        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.text(longErrorMessage), findsOneWidget);
      });
    });

    group('Widget Structure', () {
      testWidgets('maintains proper widget hierarchy', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorInline(
                title: 'Error Title',
                error: 'Error message',
                onRetry: () {},
              ),
            ),
          ),
        );

        // Verify main container
        expect(find.byType(Container), findsOneWidget);
        
        // Verify column structure
        expect(find.byType(Column), findsOneWidget);
        
        // Verify icon, title, error message, and button are all present
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.text('Error Title'), findsOneWidget);
        expect(find.text('Error message'), findsOneWidget);
        expect(find.text('Reintentar'), findsOneWidget); // Button text instead of button type
      });
    });
  });
}