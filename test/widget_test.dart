import 'package:assignment_two_flutter_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('navigates the four pages and shows student details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const StudyApp());

    expect(find.text('Good morning,'), findsOneWidget);
    expect(find.text('Md Yasin Shams Chowdhury'), findsOneWidget);
    expect(find.text('Lab 6: Navigation and routing'), findsOneWidget);

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();
    expect(find.text('Read chapter 7: Normalization'), findsOneWidget);

    await tester.tap(find.text('Read chapter 7: Normalization'));
    await tester.pump();
    final title = tester.widget<Text>(
      find.text('Read chapter 7: Normalization'),
    );
    expect(title.style?.decoration, TextDecoration.lineThrough);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('2230605'), findsWidgets);
    expect(find.text('2230605@iub.edu.bd'), findsOneWidget);
    expect(find.text('01845001272'), findsOneWidget);
    expect(find.text('Computer Science'), findsOneWidget);
    expect(find.text('Autumn 2026'), findsOneWidget);

    await tester.tap(find.text('Progress'));
    await tester.pumpAndSettle();
    expect(find.text('CSE 464 · Mobile Dev'), findsOneWidget);
    expect(find.text('This week · 9 to 15 Nov'), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text("TODAY'S STUDY GOAL"), findsOneWidget);
  });
}
