import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helper.dart';

void main() {
  testWidgets(
      'Creating an expansion button '
      '--> Icon will be wrapped in a Rotation transition ', (tester) async {
    await tester.pumpWidget(ExpansionIcon(
      contoller: FakeExpandableController(),
      vsync: const TestVSync(),
    ).wrapDirectional());

    expect(
        find.descendant(
            of: find.byType(RotationTransition), matching: find.byType(Icon)),
        findsOneWidget);
  });

  testWidgets(
      'Creating an expansion button with custom icon '
      '--> Icon should be applied ', (tester) async {
    await tester.pumpWidget(ExpansionIcon(
      contoller: FakeExpandableController(),
      vsync: const TestVSync(),
      icon: Icons.add,
    ).wrapDirectional());

    var icon = tester.firstWidget<Icon>(find.descendant(
        of: find.byType(RotationTransition), matching: find.byType(Icon)));

    expect(icon.icon, Icons.add);
  });

  testWidgets(
      'Creating an expansion button '
      '--> initial state of RotationTransition is at start angle (equivalent to radian)',
      (tester) async {
    await tester.pumpWidget(ExpansionIcon(
      contoller: FakeExpandableController(),
      startAngleRad: 0.123,
      vsync: const TestVSync(),
    ).wrapDirectional());

    var rotTransition =
        tester.widget<RotationTransition>(find.byType(RotationTransition));

    var angleAsTurns = 0.123 / (2 * 3.1415);

    expect(rotTransition.turns.value, angleAsTurns);
  });

  testWidgets(
      'Trigger the rotation of an expansion button '
      '--> final state of RotationTransition is at stop angle (equivalent to radian)',
      (tester) async {
    var expansionCtrl = FakeExpandableController();
    await tester.pumpWidget(ExpansionIcon(
      contoller: expansionCtrl,
      startAngleRad: 0.0,
      stopAngleRad: 0.456,
      vsync: const TestVSync(),
    ).wrapDirectional());

    expansionCtrl.toggle();

    await tester.pumpAndSettle();

    var rotTransition =
        tester.widget<RotationTransition>(find.byType(RotationTransition));

    var angleAsTurns = 0.456 / (2 * 3.1415);

    expect(rotTransition.turns.value, angleAsTurns);
  });

  testWidgets(
      'Trigger the reverse rotation of an expansion button by clicking twice '
      '--> final state of RotationTransition is at start angle (equivalent to radian)',
      (tester) async {
    var expansionCtrl = FakeExpandableController();
    await tester.pumpWidget(ExpansionIcon(
      contoller: expansionCtrl,
      startAngleRad: 0.0,
      stopAngleRad: 0.456,
      vsync: const TestVSync(),
    ).wrapDirectional());

    expansionCtrl.toggle();

    await tester.pumpAndSettle();

    expansionCtrl.toggle();

    await tester.pumpAndSettle();

    var rotTransition =
        tester.widget<RotationTransition>(find.byType(RotationTransition));

    expect(rotTransition.turns.value, 0);
  });
}

class FakeExpandableController extends ChangeNotifier
    implements ExpandableController {
  @override
  bool expanded = false;

  @override
  bool value = false;

  @override
  void toggle() {
    expanded = !expanded;
    notifyListeners();
  }
}
