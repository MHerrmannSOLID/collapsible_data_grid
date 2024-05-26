import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helper.dart';

void main() {
  testWidgets(
      'Given a GridCellData with a background color of 100, 120, 160, 200, '
      '--> Expect to find a container with same color ', (tester) async {
    await tester.pumpWidget(GridCellData<num>(
            backgroundColor: Color.fromARGB(100, 120, 160, 200),
            groupKey: 4711,
            child: const SizedBox(width: 10, height: 10))
        .buildCell()
        .wrapDirectional());

    var background =
        (tester.firstWidget(find.byType(Container)) as Container).color;
    expect(background!.alpha, 100);
    expect(background.red, 120);
    expect(background.green, 160);
    expect(background.blue, 200);
  });

  testWidgets(
      'Creating a GridCell with a containing a child element '
      '--> the child element should be rendered. ', (tester) async {
    await tester.pumpWidget(GridCellData<num>(
      groupKey: 123,
      child: Container(key: const Key('childElement')),
    ).buildCell().wrapDirectional());

    expect(find.byKey(const Key('childElement')), findsOneWidget);
  });
}
