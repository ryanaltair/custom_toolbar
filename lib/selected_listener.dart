import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/selection.dart';

class SelectedListener extends StatefulWidget {
  const SelectedListener({super.key, required this.child});
  final Widget child;

  @override
  State<SelectedListener> createState() => _SelectedListenerState();
}

class _SelectedListenerState extends State<SelectedListener> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
