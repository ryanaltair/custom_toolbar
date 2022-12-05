import 'dart:developer';

import 'package:custom_toolbar/desktop_selection_controls.dart';
import 'package:custom_toolbar/global.dart';
import 'package:flutter/material.dart';

class SelectedLine extends StatefulWidget {
  const SelectedLine(this.text, {super.key});
  final String text;

  @override
  State<SelectedLine> createState() => _SelectedLineState();
}

int counter = 0;

class _SelectedLineState extends State<SelectedLine> {
  String selected = '';
  final selectionControls = DesktopSelectionControls();
  late final TextEditingController controller;
  late String name;
  @override
  void initState() {
    super.initState();
    counter++;
    name = 'text${counter}';
    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.limeAccent,
      child: SizedBox(
        height: 50,
        width: 300,
        child: FocusScope(
          onFocusChange: (value) {
            print('$name onFocusChange $value');
            if (value == false) {
              // setState(() {
              //   print('onFocusChange $value rebuild');
              //   selected = '';
              // });
            }
          },
          child: SelectableText(
            widget.text,
            focusNode: FocusNode(),
            toolbarOptions: const ToolbarOptions(
                copy: false, cut: false, paste: false, selectAll: false),
            onSelectionChanged: (selection, cause) {
              GlobalStore.selected = selection.textInside(widget.text);
              selected = selection.textInside(widget.text);
              print('onSelectionChanged $cause $selected ');
            },
            selectionControls: selectionControls,
            cursorColor: Colors.blueAccent,
            style: DefaultTextStyle.of(context).style,
            onTap: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 30,
                    color: Colors.black38,
                  );
                },
              );
            },
          ),
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
