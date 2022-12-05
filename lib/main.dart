import 'package:custom_toolbar/desktop_selection_controls.dart';
import 'package:custom_toolbar/global.dart';
import 'package:custom_toolbar/selected_content_wrapper.dart';
import 'package:flutter/material.dart';

import 'gesture.dart';
import 'text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 500,
        child: ListView(
          children: const [
            SelectedContentWrapper(
                child: CloneWrapper(
              title: 'TextLine',
              child: TextLine('TextLine'),
            )),
            CloneWrapper(
                title: 'SelectedLine', child: SelectedLine('SelectedLine')),
            SelectedContentWrapper(
              child: CloneWrapper(
                  title: 'detector TextLine',
                  child: GestureWrapper.detector(
                      child: TextLine('detector TextLine '))),
            ),
            SelectedContentWrapper(
              child: CloneWrapper(
                  title: 'listener TextLine ',
                  child: GestureWrapper.listener(
                      child: TextLine('listener TextLine '))),
            ),
            CloneWrapper(
              child: GestureWrapper.detector(
                  child: SelectedContentWrapper(
                      child: TextLine('detector wrapper TextLine'))),
            ),
            CloneWrapper(
              child: GestureWrapper.listener(
                  child: SelectedContentWrapper(
                      child: TextLine('listener wrapper TextLine'))),
            ),
            CloneWrapper(
              child: GestureWrapper.detector(
                  child: SelectedContentWrapper(
                      child: SelectedLine('detector wrapper SelectedLine'))),
            ),
            CloneWrapper(
              child: GestureWrapper.listener(
                  child: SelectedContentWrapper(
                      child: SelectedLine('listener wrapper Selected'))),
            ),
          ],
        ),
      ),
    );
  }
}

class CloneWrapper extends StatelessWidget {
  const CloneWrapper({super.key, required this.child, this.title = ''});
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(title), child, child, child],
    );
  }
}
