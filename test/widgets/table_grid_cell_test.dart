import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:collapsible_data_grid/src/widgets/table_grid_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Pumping a Table grid cell data with border decoration data '
      '--> Decorated cell  will be created with the border decoration data',
      (tester) async {
    await tester.pumpWidget(
      Row(
        children: [
          TableGridCell(
            cellData: GridCellData(
              child: const Text('Cell 1'),
              groupKey: '',
            ),
            weight: 1,
          )
        ],
      ).wrapDirectional().addThemeProvider(
            collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
              cellTheme: DecoratedCellThemeData(
                dataCellDecoration: const CellBorderConfiguration(
                  topBorder: BorderSide(color: Colors.black, width: 1),
                  rightBorder: BorderSide(color: Colors.yellow, width: 2),
                  leftBorder: BorderSide(color: Colors.red, width: 3),
                  bottomBorder: BorderSide(color: Colors.green, width: 4),
                ),
              ),
            ),
          ),
    );

    var decoratedCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));

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
}
