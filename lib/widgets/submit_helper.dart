import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubmitHelper {
  static void handleKeyboardSubmit({
    required BuildContext context,
    required VoidCallback onSubmit,
  }) {
    FocusScope.of(context).unfocus(); // Keyboard dismiss
    onSubmit();
  }

  static Widget shortcutListener({
    required Widget child,
    required BuildContext context,
    required VoidCallback onSubmit,
  }) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => handleKeyboardSubmit(
              context: context,
              onSubmit: onSubmit,
            ),
          ),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}
