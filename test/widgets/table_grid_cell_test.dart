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
      ).wrapDirectional(),
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
      ).wrapDirectional(),
    );

    var tableGridCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));
    expect(tableGridCell.background, Colors.green);
  });

  testWidgets(
      'Pumping a Table grid cell data with border decoration data '
      '--> Decorated cell  will be created with the border decoration data',
      (tester) async {
    await tester.pumpWidget(
      Row(
        children: [
          TableGridCell(
            cellBorder: const CellBorderConfiguration(
              topBorder: BorderSide(color: Colors.black, width: 1),
              rightBorder: BorderSide(color: Colors.yellow, width: 2),
              leftBorder: BorderSide(color: Colors.red, width: 3),
              bottomBorder: BorderSide(color: Colors.green, width: 4),
            ),
            background: Colors.yellowAccent,
            cellData: GridCellData(
              child: const Text('Cell 1'),
              groupKey: '',
            ),
            weight: 1,
          )
        ],
      ).wrapDirectional(),
    );

    var decoratedCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));
    expect(decoratedCell.background, Colors.yellowAccent);
    var cellBorder = decoratedCell.borderConfiguration!;
    expect(cellBorder.topBorder.color, Colors.black);
    expect(cellBorder.topBorder.width, 1);
    expect(cellBorder.rightBorder.color, Colors.yellow);
    expect(cellBorder.rightBorder.width, 2);
    expect(cellBorder.leftBorder.color, Colors.red);
    expect(cellBorder.leftBorder.width, 3);
    expect(cellBorder.bottomBorder.color, Colors.green);
    expect(cellBorder.bottomBorder.width, 4);
  });

  testWidgets(
      'Pumping a Table grid cell data with border decoration data and decorated cell which also includes a border decoration'
      '--> Decorated cell will be created with the Grd cell data border sinc that overules the global setting',
      (tester) async {
    await tester.pumpWidget(
      Row(
        children: [
          TableGridCell(
            cellBorder: const CellBorderConfiguration(
              topBorder: BorderSide(color: Colors.green, width: 4),
              rightBorder: BorderSide(color: Colors.red, width: 3),
              leftBorder: BorderSide(color: Colors.yellow, width: 2),
              bottomBorder: BorderSide(color: Colors.black, width: 1),
            ),
            background: Colors.yellowAccent,
            cellData: GridCellData(
              borderConfiguration: const CellBorderConfiguration(
                topBorder: BorderSide(color: Colors.black, width: 1),
                rightBorder: BorderSide(color: Colors.yellow, width: 2),
                leftBorder: BorderSide(color: Colors.red, width: 3),
                bottomBorder: BorderSide(color: Colors.green, width: 4),
              ),
              child: const Text('Cell 1'),
              groupKey: '',
            ),
            weight: 1,
          )
        ],
      ).wrapDirectional(),
    );

    var decoratedCell =
        tester.firstWidget<DecoratedCell>(find.byType(DecoratedCell));
    expect(decoratedCell.background, Colors.yellowAccent);
    var cellBorder = decoratedCell.borderConfiguration!;
    expect(cellBorder.topBorder.color, Colors.black);
    expect(cellBorder.topBorder.width, 1);
    expect(cellBorder.rightBorder.color, Colors.yellow);
    expect(cellBorder.rightBorder.width, 2);
    expect(cellBorder.leftBorder.color, Colors.red);
    expect(cellBorder.leftBorder.width, 3);
    expect(cellBorder.bottomBorder.color, Colors.green);
    expect(cellBorder.bottomBorder.width, 4);
  });
}
