import 'package:flutter/material.dart';

/// Types of loading indicators available
enum LoadingType {
  circular,
  linear,
  adaptive,
}

/// Layout orientation for the loading spinner
enum LoadingLayout {
  vertical,
  horizontal,
}

class LoadingSpinner extends StatelessWidget {
  final String? message;
  final Color? color;
  final LoadingType type;
  final LoadingLayout layout;
  final double? size;
  final double? strokeWidth;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? progress;
  final bool showProgress;

  const LoadingSpinner({
    super.key,
    this.message,
    this.color,
    this.type = LoadingType.circular,
    this.layout = LoadingLayout.vertical,
    this.size,
    this.strokeWidth,
    this.textStyle,
    this.padding,
    this.spacing = 16.0,
    this.backgroundColor,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.progress,
    this.showProgress = false,
  });

  /// Creates a loading spinner as an overlay
  static Widget overlay({
    required Widget child,
    required bool isLoading,
    String? message,
    Color? color,
    Color? overlayColor,
    LoadingType type = LoadingType.circular,
    double? size,
  }) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: overlayColor ?? Colors.black.withAlpha(128),
              child: Center(
                child: LoadingSpinner(
                  message: message,
                  color: color ?? Colors.white,
                  type: type,
                  size: size,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.primaryColor;
    final effectiveTextStyle = textStyle ?? 
        theme.textTheme.bodyMedium?.copyWith(
          color: effectiveColor,
          fontWeight: FontWeight.w500,
        );

    final indicatorWidget = _buildIndicator(effectiveColor, theme);
    final messageWidget = _buildMessage(effectiveTextStyle);

    Widget content;
    
    if (layout == LoadingLayout.horizontal) {
      content = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          indicatorWidget,
          if (messageWidget != null) ...[
            SizedBox(width: spacing),
            messageWidget,
          ],
        ],
      );
    } else {
      content = Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          indicatorWidget,
          if (messageWidget != null) ...[
            SizedBox(height: spacing),
            messageWidget,
          ],
        ],
      );
    }

    if (backgroundColor != null || padding != null) {
      content = Container(
        padding: padding,
        decoration: backgroundColor != null
            ? BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              )
            : null,
        child: content,
      );
    }

    return content;
  }

  Widget _buildIndicator(Color effectiveColor, ThemeData theme) {
    switch (type) {
      case LoadingType.circular:
        return SizedBox(
          width: size ?? 24.0,
          height: size ?? 24.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            strokeWidth: strokeWidth ?? 4.0,
            value: showProgress ? progress : null,
          ),
        );
      
      case LoadingType.linear:
        return SizedBox(
          width: size ?? 200.0,
          height: strokeWidth ?? 4.0,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            backgroundColor: effectiveColor.withAlpha(77),
            value: showProgress ? progress : null,
          ),
        );
      
      case LoadingType.adaptive:
        return SizedBox(
          width: size ?? 24.0,
          height: size ?? 24.0,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            strokeWidth: strokeWidth ?? 4.0,
            value: showProgress ? progress : null,
          ),
        );
    }
  }

  Widget? _buildMessage(TextStyle? effectiveTextStyle) {
    if (message?.isNotEmpty != true) return null;

    Widget messageText = Text(
      message!,
      style: effectiveTextStyle,
      textAlign: TextAlign.center,
    );

    // Show progress percentage if enabled
    if (showProgress && progress != null) {
      final percentage = (progress! * 100).round();
      messageText = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          messageText,
          const SizedBox(height: 4),
          Text(
            '$percentage%',
            style: effectiveTextStyle?.copyWith(
              fontSize: (effectiveTextStyle.fontSize ?? 14) * 0.8,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    }

    return messageText;
  }
}
