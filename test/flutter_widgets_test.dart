// Main test suite for flutter_widgets package
// 
// This file serves as the entry point for all widget tests.
// Individual widget tests are organized in subdirectories by category.
// 
// To run all tests: flutter test
// To run specific category: flutter test test/feedback_test.dart
// To run individual widget: flutter test test/feedback/error_compact_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'feedback_test.dart' as feedback_tests;

void main() {
  group('Flutter Widgets Package Tests', () {
    group('Feedback Widgets', () {
      feedback_tests.main();
    });
    
    // Future test groups will be added here:
    // group('Control Widgets', () {
    //   control_tests.main();
    // });
    
    // group('Form Widgets', () {
    //   form_tests.main();
    // });
    
    // group('Layout Widgets', () {
    //   layout_tests.main();
    // });
  });
}
