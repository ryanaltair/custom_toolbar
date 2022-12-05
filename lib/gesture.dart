import 'package:flutter/material.dart';

import 'desktop_text_selection_controls_toolbar.dart';
import 'global.dart';

class GestureWrapper extends StatefulWidget {
  const GestureWrapper.listener({
    super.key,
    required this.child,
  }) : useListener = true;
  const GestureWrapper.detector({
    super.key,
    required this.child,
  }) : useListener = false;
  final bool useListener;
  final Widget child;

  @override
  State<GestureWrapper> createState() => _GestureWrapperState();
}

class _GestureWrapperState extends State<GestureWrapper> {
  bool focus = false;
  void onPointerShow(PointerDownEvent event, BuildContext context) async {
    // event.position;
    if (event.buttons == 1) {
      onShow(context, true);
      return;
    }
    if (event.buttons == 2) {
      onShow(context, false);
      return;
    }
  }

  void onTapShow(BuildContext context, bool left) {
    onShow(context, left);
  }

  void onShow(BuildContext context, bool left) async {
    final selected = GlobalStore.selected;
    await Future.delayed(Duration(milliseconds: 300));
    // if (focus) return;
    if (DesktopTextSelectionControlsToolbar.toolbarIsShow) return;
    showBottomSheet(
      context: context,
      builder: (context) {
        final text = (left ? '👈' : '👉') +
            (focus ? '🪞' : '') +
            (selected.isEmpty ? '空白' : '文本') +
            DateTime.now().toString();
        return Row(
          children: [
            const Spacer(),
            Container(
              color: Colors.greenAccent,
              height: 50,
              width: 200,
              child: Text(text),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (value) {
        focus = value;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: widget.useListener
            ? Listener(
                onPointerDown: (event) => onPointerShow(event, context),
                child: widget.child,
              )
            : GestureDetector(
                onSecondaryTap: () => onTapShow(context, false),
                // onTap: () => onTapShow(context, true),
                child: widget.child),
      ),
    );
  }
}
