import 'package:custom_toolbar/selected_content_wrapper.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            GestureWrapper(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextLine('GestureWrapper'),
            )),
            GestureWrapper(
                child: SelectedContentWrapper(child: TextLine('rowOne'))),
            SelectedContentWrapper(child: TextLine('rowOne')),
          ],
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
      color: Colors.blue,
      child: SizedBox(
        height: 100,
        width: 300,
        child: Text(text),
      ),
    );
  }
}

class GestureWrapper extends StatelessWidget {
  const GestureWrapper({super.key, required this.child});
  final Widget child;
  void onShow(BuildContext context) {
    print('show');
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber,
          height: 200,
          width: 200,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        // onPointerDown: (event) => onShow(context),
        onSecondaryTap: () => onShow(context),
        onTap: () => onShow(context),
        child: child,
      ),
    );
  }
}
