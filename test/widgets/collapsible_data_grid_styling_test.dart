import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:collapsible_data_grid/src/widgets/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/static_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

extension DecoratedCellHelper on WidgetTester {
  Border extractBorderFrom(DecoratedCell cell) {
    var container = this.firstWidget(find.descendant(
        of: find.byWidget(cell),
        matching: find.byType(Container))) as Container;

    return (container.decoration as BoxDecoration).border as Border;
  }

  Iterable<DecoratedCell> getAllCellsOf(Widget staticRow) {
    return widgetList(find.descendant(
            of: find.byWidget(staticRow), matching: find.byType(DecoratedCell)))
        .cast<DecoratedCell>();
  }
}

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
        'Creating a grid with a static grid row and the grlobal background of color red'
        '--> Background color will be supplied to the static row .',
        (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          bodyBackground: Colors.red,
          columnConfigurations: testColumns,
          rowConfigurations: [
            RowConfiguration(cells: [1, 2])
          ],
          controller: CollapsibleGridController(),
          collapseByColumn: 1,
        ),
      ).wrapDirectional());

      var tableHeader =
          tester.firstWidget<StaticTableRow>(find.byType(StaticTableRow));
      expect(tableHeader.background, Colors.red);
    });

    testWidgets(
        'Creating a datagrid with predefined cell decoration and one static row '
        '--> cell decoration is getting passed to the static row .',
        (tester) async {
      await tester.pumpWidget(
        Material(
          child: CollapsibleDataGrid(
            columnConfigurations: testColumns,
            rowConfigurations: [
              RowConfiguration(cells: [1, 2])
            ],
            controller: CollapsibleGridController(),
            collapseByColumn: 1,
          ),
        ).wrapDirectional(
          collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
            dataCellDecoration: const CellBorderConfiguration(
              topBorder: BorderSide(color: Colors.black, width: 1),
              rightBorder: BorderSide(color: Colors.yellow, width: 2),
              leftBorder: BorderSide(color: Colors.red, width: 3),
              bottomBorder: BorderSide(color: Colors.green, width: 4),
            ),
          ),
        ),
      );

      var staticRow =
          tester.firstWidget<StaticTableRow>(find.byType(StaticTableRow));

      for (var decoratedCell in tester.getAllCellsOf(staticRow)) {
        var cellBorder = tester.extractBorderFrom(decoratedCell);

        expect(cellBorder.top.color, Colors.black);
        expect(cellBorder.top.width, 1);
        expect(cellBorder.right.color, Colors.yellow);
        expect(cellBorder.right.width, 2);
        expect(cellBorder.left.color, Colors.red);
        expect(cellBorder.left.width, 3);
        expect(cellBorder.bottom.color, Colors.green);
        expect(cellBorder.bottom.width, 4);
      }
    });

    testWidgets(
        'Creating a grid with a expandable grid row and the grlobal background of color red'
        '--> Background color will be supplied to the expandable row .',
        (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          bodyBackground: Colors.red,
          columnConfigurations: testColumns,
          rowConfigurations: [
            RowConfiguration(cells: [1, 2]),
            RowConfiguration(cells: [2, 2])
          ],
          controller: CollapsibleGridController(),
          collapseByColumn: 1,
        ),
      ).wrapDirectional());

      var tableHeader = tester
          .firstWidget<ExpandableTableRow>(find.byType(ExpandableTableRow));
      expect(tableHeader.background, Colors.red);
    });

    testWidgets(
        'Creating a datagrid with predefined cell decoration and one expandable row '
        '--> cell decoration is getting passed to the expandable row .',
        (tester) async {
      await tester.pumpWidget(
        Material(
          child: CollapsibleDataGrid(
            columnConfigurations: testColumns,
            rowConfigurations: [
              RowConfiguration(cells: [1, 2]),
              RowConfiguration(cells: [3, 2])
            ],
            controller: CollapsibleGridController(),
            collapseByColumn: 1,
          ),
        ).wrapDirectional(
          collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
            dataCellDecoration: const CellBorderConfiguration(
              topBorder: BorderSide(color: Colors.black, width: 1),
              rightBorder: BorderSide(color: Colors.yellow, width: 2),
              leftBorder: BorderSide(color: Colors.red, width: 3),
              bottomBorder: BorderSide(color: Colors.green, width: 4),
            ),
          ),
        ),
      );

      var expandableRow = tester
          .firstWidget<ExpandableTableRow>(find.byType(ExpandableTableRow));

      for (var decoratedCell in tester.getAllCellsOf(expandableRow)) {
        var cellBorder = tester.extractBorderFrom(decoratedCell);
        expect(cellBorder.top.color, Colors.black);
        expect(cellBorder.top.width, 1);
        expect(cellBorder.right.color, Colors.yellow);
        expect(cellBorder.right.width, 2);
        expect(cellBorder.left.color, Colors.red);
        expect(cellBorder.left.width, 3);
        expect(cellBorder.bottom.color, Colors.green);
        expect(cellBorder.bottom.width, 4);
      }
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
