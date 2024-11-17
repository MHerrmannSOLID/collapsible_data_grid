import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/types/theme/decorated_cell_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Creating a decorated cell with border configuration'
      '--> Children content will be rendered', (tester) async {
    await tester.pumpWidget(DecoratedCell(
      cellTheme: DecoratedCellThemeData(
        dataCellDecoration: const CellBorderConfiguration(
          topBorder: BorderSide(color: Colors.black, width: 1),
          rightBorder: BorderSide(color: Colors.yellow, width: 2),
          leftBorder: BorderSide(color: Colors.red, width: 3),
          bottomBorder: BorderSide(color: Colors.green, width: 4),
        ),
      ),
      child: const Placeholder(),
    ).wrapDirectional());

    var cell = tester.firstWidget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var cellBorder = (cell.decoration as BoxDecoration).border as Border;

    expect(cellBorder.top.color, Colors.black);
    expect(cellBorder.top.width, 1);
    expect(cellBorder.right.color, Colors.yellow);
    expect(cellBorder.right.width, 2);
    expect(cellBorder.left.color, Colors.red);
    expect(cellBorder.left.width, 3);
    expect(cellBorder.bottom.color, Colors.green);
    expect(cellBorder.bottom.width, 4);
  });

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
}
