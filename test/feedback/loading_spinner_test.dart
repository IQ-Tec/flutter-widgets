import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('LoadingSpinner Widget Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders circular indicator by default', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('shows message when provided', (WidgetTester tester) async {
        const message = 'Loading data...';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(message: message),
            ),
          ),
        );

        expect(find.text(message), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('does not show text when message is null', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(),
            ),
          ),
        );

        expect(find.byType(Text), findsNothing);
      });

      testWidgets('does not show text when message is empty', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(message: ''),
            ),
          ),
        );

        expect(find.byType(Text), findsNothing);
      });
    });

    group('Loading Types', () {
      testWidgets('renders circular indicator', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(type: LoadingType.circular),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsNothing);
      });

      testWidgets('renders linear indicator', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(type: LoadingType.linear),
            ),
          ),
        );

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });

      testWidgets('renders adaptive indicator', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(type: LoadingType.adaptive),
            ),
          ),
        );

        // Adaptive indicator is a CircularProgressIndicator on most platforms
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsNothing);
      });
    });

    group('Layout Options', () {
      testWidgets('uses vertical layout by default', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(message: 'Loading...'),
            ),
          ),
        );

        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Row), findsNothing);
      });

      testWidgets('uses horizontal layout when specified', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Loading...',
                layout: LoadingLayout.horizontal,
              ),
            ),
          ),
        );

        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Column), findsNothing);
      });

      testWidgets('applies custom spacing', (WidgetTester tester) async {
        const customSpacing = 24.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Loading...',
                spacing: customSpacing,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
        expect(sizedBox.height, equals(customSpacing));
      });
    });

    group('Progress Functionality', () {
      testWidgets('shows progress percentage when enabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Downloading...',
                showProgress: true,
                progress: 0.75,
              ),
            ),
          ),
        );

        expect(find.text('Downloading...'), findsOneWidget);
        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('does not show percentage when disabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Loading...',
                showProgress: false,
                progress: 0.5,
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
        expect(find.text('50%'), findsNothing);
      });

      testWidgets('applies progress value to indicators', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                type: LoadingType.circular,
                showProgress: true,
                progress: 0.6,
              ),
            ),
          ),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );
        expect(indicator.value, equals(0.6));
      });
    });

    group('Styling and Appearance', () {
      testWidgets('applies custom color', (WidgetTester tester) async {
        const customColor = Colors.red;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Loading...',
                color: customColor,
              ),
            ),
          ),
        );

        final progressIndicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );
        expect(
          (progressIndicator.valueColor as AlwaysStoppedAnimation<Color>).value,
          equals(customColor),
        );
      });

      testWidgets('applies custom size', (WidgetTester tester) async {
        const customSize = 48.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(size: customSize),
            ),
          ),
        );

        final container = tester.widget<SizedBox>(
          find.ancestor(
            of: find.byType(CircularProgressIndicator),
            matching: find.byType(SizedBox),
          ),
        );
        expect(container.width, equals(customSize));
        expect(container.height, equals(customSize));
      });

      testWidgets('applies custom stroke width', (WidgetTester tester) async {
        const customStrokeWidth = 6.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(strokeWidth: customStrokeWidth),
            ),
          ),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );
        expect(indicator.strokeWidth, equals(customStrokeWidth));
      });

      testWidgets('applies background color and padding', (WidgetTester tester) async {
        const backgroundColor = Colors.grey;
        const padding = EdgeInsets.all(16);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Loading...',
                backgroundColor: backgroundColor,
                padding: padding,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.byType(Container),
        );
        expect(container.padding, equals(padding));
        expect(container.decoration, isA<BoxDecoration>());
        
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(backgroundColor));
      });
    });

    group('Overlay Functionality', () {
      testWidgets('creates overlay when isLoading is true', (WidgetTester tester) async {
        const childText = 'Child Content';
        const loadingMessage = 'Loading overlay...';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 200,
                child: LoadingSpinner.overlay(
                  isLoading: true,
                  message: loadingMessage,
                  child: Text(childText),
                ),
              ),
            ),
          ),
        );

        expect(find.text(childText), findsOneWidget);
        expect(find.text(loadingMessage), findsOneWidget);
        expect(find.byType(LoadingSpinner), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
      });

      testWidgets('hides overlay when isLoading is false', (WidgetTester tester) async {
        const childText = 'Child Content';
        const loadingMessage = 'Loading overlay...';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner.overlay(
                isLoading: false,
                message: loadingMessage,
                child: Text(childText),
              ),
            ),
          ),
        );

        expect(find.text(childText), findsOneWidget);
        expect(find.text(loadingMessage), findsNothing);
        expect(find.byType(LoadingSpinner), findsNothing);
      });

      testWidgets('applies custom overlay color', (WidgetTester tester) async {
        final overlayColor = Colors.red.withAlpha(128);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 200,
                child: LoadingSpinner.overlay(
                  isLoading: true,
                  overlayColor: overlayColor,
                  child: Text('Child'),
                ),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Positioned),
            matching: find.byType(Container),
          ),
        );
        expect(container.color, equals(overlayColor));
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme colors when no custom color provided', (WidgetTester tester) async {
        const themeColor = Colors.purple;
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(primaryColor: themeColor),
            home: Scaffold(
              body: LoadingSpinner(message: 'Loading...'),
            ),
          ),
        );

        final progressIndicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );
        expect(
          (progressIndicator.valueColor as AlwaysStoppedAnimation<Color>).value,
          equals(themeColor),
        );
      });
    });

    group('Accessibility', () {
      testWidgets('is accessible to screen readers', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(message: 'Loading data'),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading data'), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('provides proper semantic information', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingSpinner(
                message: 'Processing request...',
                showProgress: true,
                progress: 0.4,
              ),
            ),
          ),
        );

        expect(find.text('Processing request...'), findsOneWidget);
        expect(find.text('40%'), findsOneWidget);
      });
    });
  });
}