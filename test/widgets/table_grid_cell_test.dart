import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:collapsible_data_grid/src/widgets/table_grid_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Pumping a Table grid cell data with color red '
      '--> Decorated cell  will be created with red background ',
      (tester) async {
    await tester.pumpWidget(
      Row(
        children: [
          TableGridCell(
            background: Colors.red,
            cellData: GridCellData(
              child: const Text('Cell 1'),
              groupKey: '',
            ),
            weight: 1,
          )
        ],
      ).wrapDirectional().addThemeProvider(),
    );

    var tableGridCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));
    expect(tableGridCell.background, Colors.red);
  });

  testWidgets(
      'Pumping a Table grid cell data with color red but having no weight also a color defined in GridCellData'
      '--> grdi cell data overrules the general background color ',
      (tester) async {
    await tester.pumpWidget(
      Row(
        children: [
          TableGridCell(
            background: Colors.red,
            cellData: GridCellData(
              backgroundColor: Colors.green,
              child: const Text('Cell 1'),
              groupKey: '',
            ),
            weight: 1,
          )
        ],
      ).wrapDirectional().addThemeProvider(),
    );

    var tableGridCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));
    expect(tableGridCell.background, Colors.green);
  });
}
