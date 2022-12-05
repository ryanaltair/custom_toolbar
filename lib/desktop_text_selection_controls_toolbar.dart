import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'desktop_text_selection_toolbar.dart';
import 'desktop_text_selection_toolbar_button.dart';
import 'global.dart';

class DesktopTextSelectionControlsToolbar extends StatefulWidget {
  const DesktopTextSelectionControlsToolbar({super.key, 
    required this.clipboardStatus,
    required this.endpoints,
    required this.globalEditableRegion,
    required this.handleCopy,
    required this.handleCut,
    required this.handlePaste,
    required this.handleSelectAll,
    required this.selectionMidpoint,
    required this.textLineHeight,
    required this.lastSecondaryTapDownPosition,
  });
  static bool toolbarIsShow = false;
  final ClipboardStatusNotifier? clipboardStatus;
  final List<TextSelectionPoint> endpoints;
  final Rect globalEditableRegion;
  final VoidCallback? handleCopy;
  final VoidCallback? handleCut;
  final VoidCallback? handlePaste;
  final VoidCallback? handleSelectAll;
  final Offset? lastSecondaryTapDownPosition;
  final Offset selectionMidpoint;
  final double textLineHeight;

  @override
  State<DesktopTextSelectionControlsToolbar> createState() => _DesktopTextSelectionControlsToolbarState();
}

class _DesktopTextSelectionControlsToolbarState extends State<DesktopTextSelectionControlsToolbar> {
  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    
    DesktopTextSelectionControlsToolbar.toolbarIsShow = true;
    widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
  }

  @override
  void didUpdateWidget(DesktopTextSelectionControlsToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clipboardStatus != widget.clipboardStatus) {
      oldWidget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
      widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    DesktopTextSelectionControlsToolbar.toolbarIsShow = false;
    widget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
  }

  @override
  Widget build(BuildContext context) {
    // Don't render the menu until the state of the clipboard is known.
    if (widget.handlePaste != null && widget.clipboardStatus?.value == ClipboardStatus.unknown) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final Offset midpointAnchor = Offset(
      clampDouble(widget.selectionMidpoint.dx - widget.globalEditableRegion.left,
        mediaQuery.padding.left,
        mediaQuery.size.width - mediaQuery.padding.right,
      ),
      widget.selectionMidpoint.dy - widget.globalEditableRegion.top,
    );

    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> items = <Widget>[];

    void addToolbarButton(
      String text,
      VoidCallback onPressed,
    ) {
      items.add(DesktopTextSelectionToolbarButton.text(
        context: context,
        onPressed: onPressed,
        text: text,
      ));
    }

    if (widget.handleCut != null) {
      addToolbarButton(localizations.cutButtonLabel, widget.handleCut!);
    }
    if (widget.handleCopy != null) {
      addToolbarButton(localizations.copyButtonLabel, widget.handleCopy!);
    }
    if (widget.handlePaste != null
        && widget.clipboardStatus?.value == ClipboardStatus.pasteable) {
      addToolbarButton(localizations.pasteButtonLabel, widget.handlePaste!);
    }
    if (widget.handleSelectAll != null) {
      addToolbarButton(localizations.selectAllButtonLabel, widget.handleSelectAll!);
    }

    // If there is no option available, build an empty widget.
    if (items.isEmpty) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return DesktopTextSelectionToolbar(
      anchor: widget.lastSecondaryTapDownPosition ?? midpointAnchor,
      children: items,
    );
  }
}
