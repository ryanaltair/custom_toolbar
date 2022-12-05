import 'package:flutter/material.dart';

import 'global.dart';

class GestureWrapper extends StatelessWidget {
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
    showBottomSheet(
      context: context,
      builder: (context) {
        final text = (left ? '👈' : '👉') + (selected.isEmpty ? '空白' : '文本');
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: useListener
          ? Listener(
              onPointerDown: (event) => onPointerShow(event, context),
              child: child,
            )
          : GestureDetector(
              onSecondaryTap: () => onTapShow(context, false),
              onTap: () => onTapShow(context, true),
              child: child),
    );
  }
}
