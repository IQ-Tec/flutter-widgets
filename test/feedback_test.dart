// Main test file for all feedback widgets
// Run with: flutter test test/feedback_test.dart
// 
// This organizes all feedback widget tests in one discoverable location
// Individual tests are in the feedback/ directory for better organization

import 'feedback/error_compact_test.dart' as error_compact;
import 'feedback/error_fullscreen_test.dart' as error_fullscreen;
import 'feedback/error_inline_test.dart' as error_inline;
import 'feedback/loading_spinner_test.dart' as loading_spinner;
import 'feedback/feedback_integration_test.dart' as integration;

void main() {
  error_compact.main();
  error_fullscreen.main();
  error_inline.main();
  loading_spinner.main();
  integration.main();
}