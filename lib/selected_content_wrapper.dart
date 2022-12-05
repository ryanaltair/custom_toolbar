import 'package:flutter/material.dart';

import 'desktop_selection_controls.dart';

class SelectedContentWrapper extends StatefulWidget {
  const SelectedContentWrapper({super.key, required this.child});
  final Widget child;
  @override
  State<SelectedContentWrapper> createState() => _SelectedContentWrapperState();
}

class _SelectedContentWrapperState extends State<SelectedContentWrapper> {
  late final TextSelectionControls textSelectionControls;

  @override
  void initState() {
    textSelectionControls = DesktopSelectionControls();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
void onSelectionChanged(){

}
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      selectionControls:textSelectionControls,
      child: widget.child);
  }
}
