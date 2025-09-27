import 'package:flutter/material.dart';

/// Theme configuration for feedback widgets
/// 
/// Provides consistent styling across all feedback widgets in the library.
/// Can be customized and applied globally through `FeedbackTheme.of(context)`
class FeedbackTheme {
  /// Error-related styling
  final Color? errorColor;
  final Color? errorBackgroundColor;
  final Color? errorBorderColor;
  
  /// Success-related styling (for future widgets)
  final Color? successColor;
  final Color? successBackgroundColor;
  final Color? successBorderColor;
  
  /// Warning-related styling (for future widgets)
  final Color? warningColor;
  final Color? warningBackgroundColor;
  final Color? warningBorderColor;
  
  /// Text styling
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;
  final TextStyle? buttonStyle;
  
  /// Common styling
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final Color? shadowColor;
  
  /// Icon styling
  final double? iconSize;
  final double? largeIconSize;
  
  /// Animation durations
  final Duration? animationDuration;
  final Curve? animationCurve;

  const FeedbackTheme({
    this.errorColor,
    this.errorBackgroundColor,
    this.errorBorderColor,
    this.successColor,
    this.successBackgroundColor,
    this.successBorderColor,
    this.warningColor,
    this.warningBackgroundColor,
    this.warningBorderColor,
    this.titleStyle,
    this.bodyStyle,
    this.buttonStyle,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.iconSize,
    this.largeIconSize,
    this.animationDuration,
    this.animationCurve,
  });

  /// Creates a copy of this theme with the given fields replaced with new values.
  FeedbackTheme copyWith({
    Color? errorColor,
    Color? errorBackgroundColor,
    Color? errorBorderColor,
    Color? successColor,
    Color? successBackgroundColor,
    Color? successBorderColor,
    Color? warningColor,
    Color? warningBackgroundColor,
    Color? warningBorderColor,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? buttonStyle,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? shadowColor,
    double? iconSize,
    double? largeIconSize,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return FeedbackTheme(
      errorColor: errorColor ?? this.errorColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      successColor: successColor ?? this.successColor,
      successBackgroundColor: successBackgroundColor ?? this.successBackgroundColor,
      successBorderColor: successBorderColor ?? this.successBorderColor,
      warningColor: warningColor ?? this.warningColor,
      warningBackgroundColor: warningBackgroundColor ?? this.warningBackgroundColor,
      warningBorderColor: warningBorderColor ?? this.warningBorderColor,
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      iconSize: iconSize ?? this.iconSize,
      largeIconSize: largeIconSize ?? this.largeIconSize,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  /// Creates a default theme based on the current Material theme
  factory FeedbackTheme.fromTheme(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return FeedbackTheme(
      errorColor: colorScheme.error,
      errorBackgroundColor: colorScheme.errorContainer.withAlpha(25),
      errorBorderColor: colorScheme.error.withAlpha(75),
      successColor: colorScheme.primary,
      successBackgroundColor: colorScheme.primaryContainer.withAlpha(25),
      successBorderColor: colorScheme.primary.withAlpha(75),
      warningColor: Colors.orange,
      warningBackgroundColor: Colors.orange.withAlpha(25),
      warningBorderColor: Colors.orange.withAlpha(75),
      titleStyle: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      bodyStyle: theme.textTheme.bodyMedium,
      buttonStyle: theme.textTheme.labelLarge,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(16),
      elevation: 0,
      shadowColor: Colors.black26,
      iconSize: 20,
      largeIconSize: 48,
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
    );
  }

  /// Creates a light theme variant
  factory FeedbackTheme.light() {
    return const FeedbackTheme(
      errorColor: Color(0xFFD32F2F),
      errorBackgroundColor: Color(0xFFFFEBEE),
      errorBorderColor: Color(0xFFE57373),
      successColor: Color(0xFF388E3C),
      successBackgroundColor: Color(0xFFE8F5E8),
      successBorderColor: Color(0xFF81C784),
      warningColor: Color(0xFFF57C00),
      warningBackgroundColor: Color(0xFFFFF3E0),
      warningBorderColor: Color(0xFFFFB74D),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.all(16),
      elevation: 0,
      shadowColor: Colors.black26,
      iconSize: 20,
      largeIconSize: 48,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
    );
  }

  /// Creates a dark theme variant
  factory FeedbackTheme.dark() {
    return const FeedbackTheme(
      errorColor: Color(0xFFEF5350),
      errorBackgroundColor: Color(0xFF1B1B1B),
      errorBorderColor: Color(0xFFE57373),
      successColor: Color(0xFF66BB6A),
      successBackgroundColor: Color(0xFF1B1B1B),
      successBorderColor: Color(0xFF81C784),
      warningColor: Color(0xFFFFB74D),
      warningBackgroundColor: Color(0xFF1B1B1B),
      warningBorderColor: Color(0xFFFFCC02),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.all(16),
      elevation: 0,
      shadowColor: Colors.black54,
      iconSize: 20,
      largeIconSize: 48,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is FeedbackTheme &&
        other.errorColor == errorColor &&
        other.errorBackgroundColor == errorBackgroundColor &&
        other.errorBorderColor == errorBorderColor &&
        other.successColor == successColor &&
        other.successBackgroundColor == successBackgroundColor &&
        other.successBorderColor == successBorderColor &&
        other.warningColor == warningColor &&
        other.warningBackgroundColor == warningBackgroundColor &&
        other.warningBorderColor == warningBorderColor &&
        other.titleStyle == titleStyle &&
        other.bodyStyle == bodyStyle &&
        other.buttonStyle == buttonStyle &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.iconSize == iconSize &&
        other.largeIconSize == largeIconSize &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      errorColor,
      errorBackgroundColor,
      errorBorderColor,
      successColor,
      successBackgroundColor,
      successBorderColor,
      warningColor,
      warningBackgroundColor,
      warningBorderColor,
      titleStyle,
      bodyStyle,
      buttonStyle,
      borderRadius,
      padding,
      elevation,
      shadowColor,
      iconSize,
      largeIconSize,
      animationDuration,
      animationCurve,
    ]);
  }
}

/// Inherited widget that provides feedback theme down the widget tree
class FeedbackThemeData extends InheritedWidget {
  final FeedbackTheme theme;

  const FeedbackThemeData({
    super.key,
    required this.theme,
    required super.child,
  });

  static FeedbackTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FeedbackThemeData>()?.theme;
  }

  static FeedbackTheme of(BuildContext context) {
    final FeedbackTheme? theme = maybeOf(context);
    if (theme != null) return theme;
    
    // Fallback to creating a theme from the current Material theme
    return FeedbackTheme.fromTheme(Theme.of(context));
  }

  @override
  bool updateShouldNotify(FeedbackThemeData oldWidget) {
    return theme != oldWidget.theme;
  }
}