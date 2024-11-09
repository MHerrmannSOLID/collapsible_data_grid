import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Creating a decorated cell'
      '--> Default backgorund should be white', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DecoratedCell(child: Placeholder()),
      ).addThemeProvider(),
    );

    var cell = tester.firstWidget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var cellBorder = (cell.decoration as BoxDecoration);

    expect(cellBorder.color, isNotNull);
    expect(cellBorder.color, Colors.transparent);
  });

  testWidgets(
      'Creating a decorated cell with purple background'
      '--> Background of the inner container should be purple', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DecoratedCell(
          child: Placeholder(),
          background: Colors.purple,
        ),
      ).addThemeProvider(),
    );

    var cell = tester.firstWidget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var cellBorder = (cell.decoration as BoxDecoration);

    expect(cellBorder.color, isNotNull);
    expect(cellBorder.color, Colors.purple);
  });
}
