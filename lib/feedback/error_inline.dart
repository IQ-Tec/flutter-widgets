import 'package:flutter/material.dart';
import 'feedback_theme.dart';

class ErrorInline extends StatelessWidget {
  final String error;
  final String? title;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;
  final bool showRetryButton;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? errorStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ErrorInline({
    super.key,
    required this.error,
    this.title,
    this.buttonText,
    this.onRetry,
    this.icon,
    this.showRetryButton = true,
    this.padding,
    this.iconSize,
    this.titleStyle,
    this.errorStyle,
    this.backgroundColor,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feedbackTheme = FeedbackThemeData.of(context);

    final effectiveErrorColor = feedbackTheme.errorColor ?? theme.colorScheme.error;
    final effectivePadding = padding ?? feedbackTheme.padding ?? const EdgeInsets.all(16.0);
    final effectiveIconSize = iconSize ?? feedbackTheme.largeIconSize ?? 48.0;
    
    final effectiveTitleStyle = titleStyle ?? 
        feedbackTheme.titleStyle?.copyWith(color: effectiveErrorColor) ?? 
        theme.textTheme.titleMedium?.copyWith(
          color: effectiveErrorColor,
          fontWeight: FontWeight.bold,
        );
    
    final effectiveErrorStyle = errorStyle ?? 
        feedbackTheme.bodyStyle?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(179),
        ) ?? 
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(179),
        );

    Widget content = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon ?? Icons.error_outline,
          size: effectiveIconSize,
          color: effectiveErrorColor,
        ),
        const SizedBox(height: 16),
        if (title != null) ...[
          Text(
            title!,
            style: effectiveTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
        ],
        Flexible(
          child: SingleChildScrollView(
            child: Text(
              error,
              style: effectiveErrorStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (showRetryButton && onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(buttonText ?? 'Reintentar'),
          ),
        ],
      ],
    );

    if (backgroundColor != null) {
      content = Container(
        width: double.infinity,
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? feedbackTheme.borderRadius,
        ),
        child: content,
      );
    } else {
      content = Container(
        width: double.infinity,
        padding: effectivePadding,
        child: content,
      );
    }

    return content;
  }
}
