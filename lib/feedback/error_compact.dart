import 'package:flutter/material.dart';
import 'feedback_theme.dart';

class ErrorCompact extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final String? buttonText;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final int? maxLines;
  final TextStyle? textStyle;

  const ErrorCompact({
    super.key,
    required this.error,
    this.onRetry,
    this.buttonText,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.maxLines,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feedbackTheme = FeedbackThemeData.of(context);

    final effectiveBackgroundColor = backgroundColor ?? 
        feedbackTheme.errorBackgroundColor ?? 
        theme.colorScheme.errorContainer.withAlpha(25);
    
    final effectiveBorderColor = borderColor ?? 
        feedbackTheme.errorBorderColor ?? 
        theme.colorScheme.error.withAlpha(75);
    
    final effectiveErrorColor = feedbackTheme.errorColor ?? theme.colorScheme.error;
    final effectiveBorderRadius = borderRadius ?? feedbackTheme.borderRadius ?? BorderRadius.circular(8);
    final effectivePadding = padding ?? const EdgeInsets.all(12.0);
    final effectiveIconSize = iconSize ?? feedbackTheme.iconSize ?? 20.0;
    final effectiveMaxLines = maxLines ?? 2;

    final effectiveTextStyle = textStyle ?? 
        feedbackTheme.bodyStyle?.copyWith(color: effectiveErrorColor) ?? 
        theme.textTheme.bodySmall?.copyWith(color: effectiveErrorColor);

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: Border.all(color: effectiveBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline, 
            size: effectiveIconSize, 
            color: effectiveErrorColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: effectiveTextStyle,
              maxLines: effectiveMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              iconSize: effectiveIconSize * 0.9,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: buttonText ?? 'Reintentar',
            ),
          ],
        ],
      ),
    );
  }
}
