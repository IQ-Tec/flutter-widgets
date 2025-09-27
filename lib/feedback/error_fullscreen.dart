import 'package:flutter/material.dart';

class ErrorFullScreen extends StatelessWidget {
  final String error;
  final String? title;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool barrierDismissible;
  final Color? barrierColor;
  final bool useSafeArea;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? actions;

  const ErrorFullScreen({
    super.key,
    required this.error,
    this.title,
    this.buttonText,
    this.onPressed,
    this.barrierDismissible = false,
    this.barrierColor,
    this.useSafeArea = true,
    this.contentPadding,
    this.actions,
  });

  /// Shows the error dialog using the proper Flutter dialog system
  /// 
  /// Returns a Future that completes when the dialog is dismissed
  static Future<T?> show<T>({
    required BuildContext context,
    required String error,
    String? title,
    String? buttonText,
    VoidCallback? onPressed,
    bool barrierDismissible = false,
    Color? barrierColor,
    bool useSafeArea = true,
    EdgeInsetsGeometry? contentPadding,
    List<Widget>? actions,
    bool useRootNavigator = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return ErrorFullScreen(
          error: error,
          title: title,
          buttonText: buttonText,
          onPressed: onPressed,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          useSafeArea: useSafeArea,
          contentPadding: contentPadding,
          actions: actions,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: barrierDismissible,
      child: AlertDialog(
        title: Text(title ?? 'Error'),
        content: SingleChildScrollView(
          child: Text(error),
        ),
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        actions: actions ?? [
          TextButton(
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            child: Text(buttonText ?? 'Continuar'),
          ),
        ],
      ),
    );
  }
}
