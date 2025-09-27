import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('Feedback Widgets Integration Tests', () {
    testWidgets('multiple feedback widgets work together in state management', (WidgetTester tester) async {
      bool isLoading = true;
      bool hasError = false;
      String? errorMessage;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                Widget buildContent() {
                  if (isLoading) {
                    return LoadingSpinner(message: 'Loading...');
                  } else if (hasError && errorMessage != null) {
                    return ErrorInline(
                      title: 'Load Failed',
                      error: errorMessage!,
                      onRetry: () {
                        setState(() {
                          isLoading = true;
                          hasError = false;
                          errorMessage = null;
                        });
                      },
                    );
                  }
                  return Text('Success! Data loaded.');
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContent(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                          hasError = true;
                          errorMessage = 'Failed to load data from server';
                        });
                      },
                      child: Text('Simulate Error'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially shows loading
      expect(find.byType(LoadingSpinner), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      // Simulate error
      await tester.tap(find.text('Simulate Error'));
      await tester.pump();

      // Now shows error
      expect(find.byType(LoadingSpinner), findsNothing);
      expect(find.byType(ErrorInline), findsOneWidget);
      expect(find.text('Load Failed'), findsOneWidget);
      expect(find.text('Failed to load data from server'), findsOneWidget);

      // Test retry functionality
      await tester.tap(find.text('Reintentar'));
      await tester.pump();

      // Back to loading
      expect(find.byType(LoadingSpinner), findsOneWidget);
      expect(find.byType(ErrorInline), findsNothing);
    });

    testWidgets('ErrorCompact works in ListView with multiple items', (WidgetTester tester) async {
      final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
      final Set<int> errorItems = {1}; // Item 2 has error
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (errorItems.contains(index)) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ErrorCompact(
                      error: 'Failed to load ${items[index]}',
                      onRetry: () {},
                    ),
                  );
                }
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ),
      );

      // Verify regular items
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      
      // Verify error item
      expect(find.text('Failed to load Item 2'), findsOneWidget);
      expect(find.byType(ErrorCompact), findsOneWidget);
      
      // Verify retry button is present
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('nested error handling with fullscreen and inline widgets', (WidgetTester tester) async {
      bool showFullScreenError = false;
      bool showInlineError = true;
      
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Stack(
                  children: [
                    // Main content with inline error
                    Center(
                      child: showInlineError
                          ? ErrorInline(
                              error: 'Connection timeout',
                              onRetry: () {
                                setState(() {
                                  showFullScreenError = true;
                                  showInlineError = false;
                                });
                              },
                            )
                          : Text('Main Content'),
                    ),
                    
                    // Fullscreen error overlay
                    if (showFullScreenError)
                      ErrorFullScreen(
                        title: 'Critical Error',
                        error: 'Unable to connect to server. Please check your internet connection.',
                        onPressed: () {
                          setState(() {
                            showFullScreenError = false;
                            showInlineError = false;
                          });
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Initially shows inline error
      expect(find.byType(ErrorInline), findsOneWidget);
      expect(find.text('Connection timeout'), findsOneWidget);

      // Tap retry to show fullscreen error
      await tester.tap(find.text('Reintentar'));
      await tester.pump();

      // Now shows fullscreen error
      expect(find.byType(ErrorFullScreen), findsOneWidget);
      expect(find.text('Critical Error'), findsOneWidget);
      expect(find.text('Unable to connect to server. Please check your internet connection.'), findsOneWidget);

      // Dismiss fullscreen error
      await tester.tap(find.text('Continuar'));
      await tester.pump();

      // Shows main content
      expect(find.text('Main Content'), findsOneWidget);
      expect(find.byType(ErrorInline), findsNothing);
      expect(find.byType(ErrorFullScreen), findsNothing);
    });

    group('Performance and Memory', () {
      testWidgets('widgets dispose properly without memory leaks', (WidgetTester tester) async {
        // Create and destroy widgets multiple times
        for (int i = 0; i < 5; i++) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    LoadingSpinner(message: 'Test $i'),
                    ErrorCompact(error: 'Error $i', onRetry: () {}),
                    ErrorInline(error: 'Inline error $i'),
                  ],
                ),
              ),
            ),
          );
          
          await tester.pump();
        }
        
        // Final state should work correctly
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Text('Final State'),
            ),
          ),
        );
        
        expect(find.text('Final State'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Theme Integration', () {
      testWidgets('widgets adapt to different theme modes', (WidgetTester tester) async {
        // Test with dark theme
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark,
            home: Scaffold(
              body: Column(
                children: [
                  ErrorCompact(error: 'Dark theme error'),
                  ErrorInline(error: 'Dark theme inline error'),
                  LoadingSpinner(message: 'Loading in dark'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Dark theme error'), findsOneWidget);
        expect(find.text('Dark theme inline error'), findsOneWidget);
        expect(find.text('Loading in dark'), findsOneWidget);
        
        // Widgets should render without issues in dark theme
        expect(tester.takeException(), isNull);
      });
    });
  });
}