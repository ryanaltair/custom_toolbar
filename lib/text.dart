import 'package:custom_toolbar/desktop_selection_controls.dart';
import 'package:custom_toolbar/global.dart';
import 'package:flutter/material.dart';

class SelectedLine extends StatelessWidget {
  const SelectedLine(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.limeAccent,
      child: SizedBox(
        height: 50,
        width: 300,
        child: SelectableText(
          text,
          toolbarOptions: const ToolbarOptions(
              copy: false, cut: false, paste: false, selectAll: false),
          onSelectionChanged: (selection, cause) {
            print('onSelectionChanged');
            GlobalStore.selected = selection.textInside(text);
          },
          selectionControls: DesktopSelectionControls(),
        ),
      ),
    );
  }
}

class TextLine extends StatelessWidget {
  const TextLine(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      child: SizedBox(
        height: 50,
        width: 300,
        child: Text(text),
      ),
    );
  }
}
