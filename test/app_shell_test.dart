import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/app_shell.dart';

void main() {
  const navBar = 48.0; // height of the phone's navigation buttons

  Widget app(Widget home) => MediaQuery(
        data: const MediaQueryData(size: Size(400, 800), padding: EdgeInsets.only(bottom: navBar)),
        child: MaterialApp(builder: withSystemInsets, home: home),
      );

  testWidgets('a form screen keeps its Save button above the navigation buttons', (tester) async {
    await tester.pumpWidget(app(Scaffold(
      appBar: AppBar(),
      body: ListView(children: [for (var i = 0; i < 30; i++) const SizedBox(height: 60), const Text('Save')]),
    )));
    await tester.drag(find.byType(ListView), const Offset(0, -5000));
    await tester.pump();

    expect(tester.getBottomLeft(find.text('Save')).dy, lessThanOrEqualTo(800 - navBar));
  });

  testWidgets('a floating button and a bottom bar stay above the navigation buttons too', (tester) async {
    await tester.pumpWidget(app(Scaffold(
      body: const SizedBox.expand(),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      bottomNavigationBar: const SizedBox(key: Key('bar'), height: 50),
    )));

    expect(tester.getBottomLeft(find.byKey(const Key('bar'))).dy, lessThanOrEqualTo(800 - navBar));
    expect(tester.getBottomLeft(find.byType(FloatingActionButton)).dy, lessThanOrEqualTo(800 - navBar));
  });
}
