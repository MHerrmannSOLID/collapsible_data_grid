import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  test(
      'Comparing two GridCellData instances with string keys'
      '--> should be same resutl like the direct comparison of the strings',
      () {
    var gc1 = GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1');
    var gc2 = GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 2');

    expect(gc1.groupKey, 'Cell 1');
    expect(gc2.groupKey, 'Cell 2');
    expect(gc1.compareTo(gc2), 'Cell 1'.compareTo('Cell 2'));
  });

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

  test("Extracting the data encapsulated in a GridCellData instance", () {
    var gc = GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1');

    expect(gc.groupKey, 'Cell 1');
    expect(gc.colSpan, 1);
    expect(gc.backgroundColor, null);
    expect(gc.borderConfiguration, null);
  });
}
