import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('ErrorFullScreen Widget Tests', () {
    group('Constructor Tests', () {
      testWidgets('renders dialog with error message', (WidgetTester tester) async {
        const errorMessage = 'Full screen error';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorFullScreen(error: errorMessage),
            ),
          ),
        );

        expect(find.text(errorMessage), findsOneWidget);
        expect(find.text('Error'), findsOneWidget); // Default title
        expect(find.text('Continuar'), findsOneWidget); // Default button text
        expect(find.byType(AlertDialog), findsOneWidget);
      });

      testWidgets('shows custom title and button text', (WidgetTester tester) async {
        const customTitle = 'Connection Error';
        const customButtonText = 'OK';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorFullScreen(
                error: 'Test error',
                title: customTitle,
                buttonText: customButtonText,
              ),
            ),
          ),
        );

        expect(find.text(customTitle), findsOneWidget);
        expect(find.text(customButtonText), findsOneWidget);
      });

      testWidgets('calls onPressed when button is tapped', (WidgetTester tester) async {
        bool buttonPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorFullScreen(
                error: 'Test error',
                onPressed: () => buttonPressed = true,
              ),
            ),
          ),
        );

        await tester.tap(find.text('Continuar'));
        expect(buttonPressed, isTrue);
      });

      testWidgets('pops navigator by default when no onPressed provided', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              body: ErrorFullScreen(error: 'Test error'),
                            ),
                          ),
                        );
                      },
                      child: Text('Show Error'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // Navigate to error screen
        await tester.tap(find.text('Show Error'));
        await tester.pumpAndSettle();

        // Verify we're on the error screen
        expect(find.text('Test error'), findsOneWidget);

        // Tap continue button (should pop)
        await tester.tap(find.text('Continuar'));
        await tester.pumpAndSettle();

        // Verify we're back to the first screen
        expect(find.text('Show Error'), findsOneWidget);
        expect(find.text('Test error'), findsNothing);
      });
    });

    group('Static show() Method Tests', () {
      testWidgets('shows dialog using showDialog', (WidgetTester tester) async {
        const errorMessage = 'Dialog error message';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    ErrorFullScreen.show(
                      context: context,
                      error: errorMessage,
                    );
                  },
                  child: Text('Show Error Dialog'),
                ),
              ),
            ),
          ),
        );

        // Show dialog
        await tester.tap(find.text('Show Error Dialog'));
        await tester.pumpAndSettle();

        // Verify dialog is shown
        expect(find.text(errorMessage), findsOneWidget);
        expect(find.text('Error'), findsOneWidget); // Default title
        expect(find.byType(AlertDialog), findsOneWidget);
      });

      testWidgets('dialog respects barrierDismissible parameter', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    ErrorFullScreen.show(
                      context: context,
                      error: 'Test error',
                      barrierDismissible: false,
                    );
                  },
                  child: Text('Show Error Dialog'),
                ),
              ),
            ),
          ),
        );

        // Show dialog
        await tester.tap(find.text('Show Error Dialog'));
        await tester.pumpAndSettle();

        // Try to dismiss by tapping outside (should not work)
        await tester.tapAt(Offset(10, 10));
        await tester.pumpAndSettle();

        // Dialog should still be visible
        expect(find.text('Test error'), findsOneWidget);
      });

      testWidgets('dialog can be dismissed when barrierDismissible is true', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    ErrorFullScreen.show(
                      context: context,
                      error: 'Test error',
                      barrierDismissible: true,
                    );
                  },
                  child: Text('Show Error Dialog'),
                ),
              ),
            ),
          ),
        );

        // Show dialog
        await tester.tap(find.text('Show Error Dialog'));
        await tester.pumpAndSettle();

        // Dismiss by tapping outside
        await tester.tapAt(Offset(10, 10));
        await tester.pumpAndSettle();

        // Dialog should be gone
        expect(find.text('Test error'), findsNothing);
      });

      testWidgets('calls custom onPressed function', (WidgetTester tester) async {
        bool customActionCalled = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    ErrorFullScreen.show(
                      context: context,
                      error: 'Test error',
                      buttonText: 'Custom Action',
                      onPressed: () {
                        customActionCalled = true;
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Text('Show Error Dialog'),
                ),
              ),
            ),
          ),
        );

        // Show dialog
        await tester.tap(find.text('Show Error Dialog'));
        await tester.pumpAndSettle();

        // Tap custom button
        await tester.tap(find.text('Custom Action'));
        await tester.pumpAndSettle();

        expect(customActionCalled, isTrue);
      });

      testWidgets('applies custom barrierColor', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    ErrorFullScreen.show(
                      context: context,
                      error: 'Test error',
                      barrierColor: Colors.red.withValues(alpha: 0.5),
                    );
                  },
                  child: Text('Show Error Dialog'),
                ),
              ),
            ),
          ),
        );

        // Show dialog
        await tester.tap(find.text('Show Error Dialog'));
        await tester.pumpAndSettle();

        // Dialog should be visible with custom barrier
        expect(find.byType(AlertDialog), findsOneWidget);
      });
    });

    group('Dialog Properties', () {
      testWidgets('dialog content is scrollable for long messages', (WidgetTester tester) async {
        final longMessage = 'Long error message. ' * 50;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorFullScreen(error: longMessage),
            ),
          ),
        );

        // Should find scrollable content
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.text(longMessage), findsOneWidget);
      });

      testWidgets('dialog has proper PopScope configuration', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorFullScreen(error: 'Test error'),
            ),
          ),
        );

        expect(find.byType(PopScope), findsOneWidget);
      });
    });
  });
}