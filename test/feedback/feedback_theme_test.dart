import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() {
  group('FeedbackTheme Tests', () {
    group('FeedbackTheme Class', () {
      testWidgets('has correct properties', (WidgetTester tester) async {
        const theme = FeedbackTheme(
          errorColor: Colors.red,
          errorBackgroundColor: Colors.pink,
          successColor: Colors.green,
          warningColor: Colors.orange,
        );
        
        expect(theme.errorColor, equals(Colors.red));
        expect(theme.errorBackgroundColor, equals(Colors.pink));
        expect(theme.successColor, equals(Colors.green));
        expect(theme.warningColor, equals(Colors.orange));
      });

      testWidgets('copyWith creates new instance with updated values', (WidgetTester tester) async {
        const originalTheme = FeedbackTheme(
          errorColor: Colors.red,
          successColor: Colors.green,
        );
        
        final updatedTheme = originalTheme.copyWith(
          errorColor: Colors.blue,
          warningColor: Colors.orange,
        );
        
        expect(updatedTheme.errorColor, equals(Colors.blue));
        expect(updatedTheme.successColor, equals(Colors.green)); // unchanged
        expect(updatedTheme.warningColor, equals(Colors.orange));
      });

      testWidgets('fromTheme creates theme from Material theme', (WidgetTester tester) async {
        final materialTheme = ThemeData.light();
        final feedbackTheme = FeedbackTheme.fromTheme(materialTheme);
        
        expect(feedbackTheme.errorColor, equals(materialTheme.colorScheme.error));
        expect(feedbackTheme.successColor, equals(materialTheme.colorScheme.primary));
        expect(feedbackTheme.warningColor, equals(Colors.orange));
        expect(feedbackTheme.borderRadius, equals(BorderRadius.circular(8)));
      });
    });

    group('FeedbackTheme Factory Methods', () {
      testWidgets('light() provides correct light theme', (WidgetTester tester) async {
        final lightTheme = FeedbackTheme.light();
        
        expect(lightTheme.errorColor, equals(const Color(0xFFD32F2F)));
        expect(lightTheme.errorBackgroundColor, equals(const Color(0xFFFFEBEE)));
        expect(lightTheme.successColor, equals(const Color(0xFF388E3C)));
        expect(lightTheme.warningColor, equals(const Color(0xFFF57C00)));
      });

      testWidgets('dark() provides correct dark theme', (WidgetTester tester) async {
        final darkTheme = FeedbackTheme.dark();
        
        expect(darkTheme.errorColor, equals(const Color(0xFFEF5350)));
        expect(darkTheme.errorBackgroundColor, equals(const Color(0xFF1B1B1B)));
        expect(darkTheme.successColor, equals(const Color(0xFF66BB6A)));
        expect(darkTheme.warningColor, equals(const Color(0xFFFFB74D)));
      });
    });

    group('FeedbackThemeData InheritedWidget', () {
      testWidgets('provides theme data to descendants', (WidgetTester tester) async {
        const customTheme = FeedbackTheme(
          errorColor: Colors.orange,
          successColor: Colors.purple,
          warningColor: Colors.yellow,
        );

        FeedbackTheme? capturedTheme;

        await tester.pumpWidget(
          MaterialApp(
            home: FeedbackThemeData(
              theme: customTheme,
              child: Builder(
                builder: (context) {
                  capturedTheme = FeedbackThemeData.of(context);
                  return Container();
                },
              ),
            ),
          ),
        );

        expect(capturedTheme, isNotNull);
        expect(capturedTheme!.errorColor, equals(Colors.orange));
        expect(capturedTheme!.successColor, equals(Colors.purple));
        expect(capturedTheme!.warningColor, equals(Colors.yellow));
      });

      testWidgets('maybeOf returns null when no theme is found', (WidgetTester tester) async {
        FeedbackTheme? capturedTheme;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                capturedTheme = FeedbackThemeData.maybeOf(context);
                return Container();
              },
            ),
          ),
        );

        expect(capturedTheme, isNull);
      });

      testWidgets('of creates fallback theme when none is found', (WidgetTester tester) async {
        FeedbackTheme? capturedTheme;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Builder(
              builder: (context) {
                capturedTheme = FeedbackThemeData.of(context);
                return Container();
              },
            ),
          ),
        );

        expect(capturedTheme, isNotNull);
        expect(capturedTheme!.errorColor, isNotNull);
        expect(capturedTheme!.successColor, isNotNull);
      });

      testWidgets('nested themes override parent themes', (WidgetTester tester) async {
        const parentTheme = FeedbackTheme(errorColor: Colors.red);
        const childTheme = FeedbackTheme(errorColor: Colors.blue);

        FeedbackTheme? capturedTheme;

        await tester.pumpWidget(
          MaterialApp(
            home: FeedbackThemeData(
              theme: parentTheme,
              child: FeedbackThemeData(
                theme: childTheme,
                child: Builder(
                  builder: (context) {
                    capturedTheme = FeedbackThemeData.of(context);
                    return Container();
                  },
                ),
              ),
            ),
          ),
        );

        expect(capturedTheme, isNotNull);
        expect(capturedTheme!.errorColor, equals(Colors.blue));
      });

      testWidgets('updateShouldNotify returns true when theme changes', (WidgetTester tester) async {
        const oldTheme = FeedbackTheme(errorColor: Colors.red);
        const newTheme = FeedbackTheme(errorColor: Colors.blue);

        const oldWidget = FeedbackThemeData(theme: oldTheme, child: SizedBox());
        const newWidget = FeedbackThemeData(theme: newTheme, child: SizedBox());

        expect(newWidget.updateShouldNotify(oldWidget), isTrue);
      });

      testWidgets('updateShouldNotify returns false when theme is the same', (WidgetTester tester) async {
        const theme = FeedbackTheme(errorColor: Colors.red);

        const oldWidget = FeedbackThemeData(theme: theme, child: SizedBox());
        const newWidget = FeedbackThemeData(theme: theme, child: SizedBox());

        expect(newWidget.updateShouldNotify(oldWidget), isFalse);
      });
    });

    group('Theme Equality', () {
      testWidgets('themes with same values are equal', (WidgetTester tester) async {
        const theme1 = FeedbackTheme(
          errorColor: Colors.red,
          errorBackgroundColor: Colors.blue,
          successColor: Colors.green,
          warningColor: Colors.orange,
        );

        const theme2 = FeedbackTheme(
          errorColor: Colors.red,
          errorBackgroundColor: Colors.blue,
          successColor: Colors.green,
          warningColor: Colors.orange,
        );

        expect(theme1 == theme2, isTrue);
        expect(theme1.hashCode == theme2.hashCode, isTrue);
      });

      testWidgets('themes with different values are not equal', (WidgetTester tester) async {
        const theme1 = FeedbackTheme(errorColor: Colors.red);
        const theme2 = FeedbackTheme(errorColor: Colors.blue);

        expect(theme1 == theme2, isFalse);
        expect(theme1.hashCode == theme2.hashCode, isFalse);
      });
    });

    group('Integration with Widgets', () {
      testWidgets('ErrorCompact can access theme', (WidgetTester tester) async {
        const customTheme = FeedbackTheme(
          errorColor: Colors.orange,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FeedbackThemeData(
                theme: customTheme,
                child: ErrorCompact(error: 'Test error'),
              ),
            ),
          ),
        );

        expect(find.text('Test error'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('LoadingSpinner can access theme', (WidgetTester tester) async {
        const customTheme = FeedbackTheme(
          successColor: Colors.green,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FeedbackThemeData(
                theme: customTheme,
                child: LoadingSpinner(message: 'Loading...'),
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('ErrorInline can access theme', (WidgetTester tester) async {
        const customTheme = FeedbackTheme(
          errorColor: Colors.red,
          errorBackgroundColor: Colors.pink,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FeedbackThemeData(
                theme: customTheme,
                child: ErrorInline(error: 'Test error'),
              ),
            ),
          ),
        );

        expect(find.text('Test error'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });
    });

    group('Theme Properties', () {
      testWidgets('all theme properties work correctly', (WidgetTester tester) async {
        const theme = FeedbackTheme(
          errorColor: Colors.red,
          errorBackgroundColor: Colors.red,
          errorBorderColor: Colors.redAccent,
          successColor: Colors.green,
          successBackgroundColor: Colors.lightGreen,
          successBorderColor: Colors.greenAccent,
          warningColor: Colors.orange,
          warningBackgroundColor: Colors.orangeAccent,
          warningBorderColor: Colors.deepOrange,
          titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodyStyle: TextStyle(fontSize: 14),
          buttonStyle: TextStyle(fontSize: 16),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          padding: EdgeInsets.all(20),
          elevation: 4,
          shadowColor: Colors.black26,
          iconSize: 24,
          largeIconSize: 56,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.bounceIn,
        );
        
        // Test all properties are accessible
        expect(theme.errorColor, equals(Colors.red));
        expect(theme.successColor, equals(Colors.green));
        expect(theme.warningColor, equals(Colors.orange));
        expect(theme.iconSize, equals(24));
        expect(theme.largeIconSize, equals(56));
        expect(theme.elevation, equals(4));
        expect(theme.animationDuration, equals(const Duration(milliseconds: 300)));
        expect(theme.animationCurve, equals(Curves.bounceIn));
      });
    });
  });
}