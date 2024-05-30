import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  var testColumns = <ColumnConfiguration>[
    ColumnConfiguration(header: const Text('Column 1')),
    ColumnConfiguration(header: const Text('Column 2')),
  ];

  group('CollapsibleDataGrid styling tests', () {
    testWidgets(
        'Creating a datagrid with predefined header background '
        '--> Background color will be supplied to the table header .',
        (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          headerBackground: Colors.indigo,
          columnConfigurations: testColumns,
          rowConfigurations: [],
          controller: CollapsibleGridController(),
          collapseByColumn: 1,
        ),
      ).wrapDirectional());

      var tableHeader =
          tester.firstWidget<TableHeader>(find.byType(TableHeader));
      expect(tableHeader.headerBackground, Colors.indigo);
    });

    testWidgets(
        'Creating a datagrid with predefined header decoration '
        '--> header decoration is getting passed to the table header .',
        (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          headerBackground: Colors.red,
          headerCellBorder: const CellBorderConfiguration(
            topBorder: BorderSide(color: Colors.black, width: 1),
            rightBorder: BorderSide(color: Colors.yellow, width: 2),
            leftBorder: BorderSide(color: Colors.red, width: 3),
            bottomBorder: BorderSide(color: Colors.green, width: 4),
          ),
          columnConfigurations: testColumns,
          rowConfigurations: [],
          controller: CollapsibleGridController(),
          collapseByColumn: 1,
        ),
      ).wrapDirectional());

      var tableHeader =
          tester.firstWidget<TableHeader>(find.byType(TableHeader));
      var cellBorder = tableHeader.borderConfiguration!;
      expect(tableHeader.headerBackground, Colors.red);

      expect(cellBorder.topBorder.color, Colors.black);
      expect(cellBorder.topBorder.width, 1);
      expect(cellBorder.rightBorder.color, Colors.yellow);
      expect(cellBorder.rightBorder.width, 2);
      expect(cellBorder.leftBorder.color, Colors.red);
      expect(cellBorder.leftBorder.width, 3);
      expect(cellBorder.bottomBorder.color, Colors.green);
      expect(cellBorder.bottomBorder.width, 4);
    });
  });
}
