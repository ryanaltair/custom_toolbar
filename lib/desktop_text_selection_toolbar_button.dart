import 'package:flutter/material.dart';

class DesktopTextSelectionToolbarButton extends StatelessWidget {
  /// Creates an instance of DesktopTextSelectionToolbarButton.
  const DesktopTextSelectionToolbarButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  /// Create an instance of [DesktopTextSelectionToolbarButton] whose child is
  /// a [Text] widget in the style of the Material text selection toolbar.
  DesktopTextSelectionToolbarButton.text({
    super.key,
    required BuildContext context,
    required this.onPressed,
    required String text,
  }) : child = Text(
          text,
          overflow: TextOverflow.ellipsis,
        );

  /// {@macro flutter.material.TextSelectionToolbarTextButton.onPressed}
  final VoidCallback onPressed;

  /// {@macro flutter.material.TextSelectionToolbarTextButton.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.center,
          enabledMouseCursor: SystemMouseCursors.basic,
          disabledMouseCursor: SystemMouseCursors.basic,
          minimumSize: const Size(kMinInteractiveDimension, 36.0),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
