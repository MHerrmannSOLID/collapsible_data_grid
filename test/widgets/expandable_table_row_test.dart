import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/static_table_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_helper.dart';

void main() {
  var testColumns = <ColumnConfiguration>[
    ColumnConfiguration(
      header: const Text('Column 1'),
    ),
    ColumnConfiguration(
        header: const Text('Column 2', key: Key('headerCell2'))),
  ];

  var expandableRows = <RowConfiguration>[
    RowConfiguration(cells: [
      GridCellData(
          child: const Text(
            'Cell 1',
            key: Key('cell1'),
          ),
          groupKey: 'Cell 1'),
      GridCellData(
          child: const Text(
            'Cell 2',
            key: Key('cell2'),
          ),
          groupKey: 'Cell 2'),
    ]),
    RowConfiguration(cells: [
      GridCellData(
          child: const Text(
            'Cell 3',
            key: Key('cell3'),
          ),
          groupKey: 'Cell 3'),
      GridCellData(
          child: const Text(
            'Cell 4',
            key: Key('cell4'),
          ),
          groupKey: 'Cell 4'),
    ]),
  ];

  var headerRow = [
    GridCellData(
        child: const Text(
          'Cell 1',
          key: Key('headerCell1'),
        ),
        groupKey: 'Cell 1'),
    GridCellData(
        child: const Text(
          'Cell 2',
          key: Key('headerCell2'),
        ),
        groupKey: 'Cell 2'),
  ];

  testWidgets(
      'Creating an expandable row (keeping it in original state --> not expanded) '
      '--> the "heade" elements are displayed', (tester) async {
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        columnConfigurations: testColumns,
        data: ExpandableRow(
          cells: headerRow,
          children: expandableRows,
        ),
      ),
    ).wrapDirectional());

    expect(find.byKey(const Key('headerCell1')), findsOneWidget);
    expect(find.byKey(const Key('headerCell2')), findsOneWidget);
  });

  testWidgets(
      'Creating an expandable row with an empty list of children '
      '--> should have only one StaticTableRow', (tester) async {
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        columnConfigurations: testColumns,
        data: ExpandableRow(
          cells: headerRow,
          children: [],
        ),
      ),
    ).wrapDirectional());

    expect(find.byType(StaticTableRow), findsOneWidget);
  });

  testWidgets(
      'Creating an expandable row '
      '--> The header StaticTableRow should get the expandeble model as data model',
      (tester) async {
    var expandableRowModel = ExpandableRow(
      cells: headerRow,
      children: [],
    );
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        columnConfigurations: testColumns,
        data: expandableRowModel,
      ),
    ).wrapDirectional());

    var staticRow =
        tester.firstWidget(find.byType(StaticTableRow)) as StaticTableRow;

    expect(staticRow.rowData, expandableRowModel);
  });

  testWidgets(
      'Creating an expandable row expanded '
      '--> call child element are not displayed', (tester) async {
    var controller = ExpandableController();
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        columnConfigurations: testColumns,
        data: ExpandableRow(
          cells: headerRow,
          children: expandableRows,
          controller: controller,
        ),
      ),
    ).wrapDirectional());

    controller.toggle();

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('cell1')), findsOneWidget);
    expect(find.byKey(const Key('cell2')), findsOneWidget);
    expect(find.byKey(const Key('cell3')), findsOneWidget);
    expect(find.byKey(const Key('cell4')), findsOneWidget);
  });

  testWidgets(
      'Creaing an expandable row with red backgorund color'
      '--> background color will be submitted to all static rows',
      (tester) async {
    var controller = ExpandableController();
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        background: Colors.red,
        columnConfigurations: testColumns,
        data: ExpandableRow(
          cells: headerRow,
          children: expandableRows,
          controller: controller,
        ),
      ),
    ).wrapDirectional());

    controller.toggle();

    await tester.pumpAndSettle();

    tester
        .widgetList<StaticTableRow>(find.byType(StaticTableRow))
        .forEach((element) {
      expect(element.background, Colors.red);
    });
  });

  testWidgets(
      'Creaing an expandable row with dedicated border configuration'
      '--> border configuration will be submitted to all static rows',
      (tester) async {
    var controller = ExpandableController();
    await tester.pumpWidget(Material(
      child: ExpandableTableRow(
        background: Colors.orange,
        cellBorder: const CellBorderConfiguration(
          topBorder: BorderSide(color: Colors.black, width: 1),
          rightBorder: BorderSide(color: Colors.yellow, width: 2),
          leftBorder: BorderSide(color: Colors.red, width: 3),
          bottomBorder: BorderSide(color: Colors.green, width: 4),
        ),
        columnConfigurations: testColumns,
        data: ExpandableRow(
          cells: headerRow,
          children: expandableRows,
          controller: controller,
        ),
      ),
    ).wrapDirectional());

    controller.toggle();

    await tester.pumpAndSettle();

    tester
        .widgetList<StaticTableRow>(find.byType(StaticTableRow))
        .forEach((element) {
      expect(element.background, Colors.orange);
      var cellBorder = element.cellBorder!;
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
