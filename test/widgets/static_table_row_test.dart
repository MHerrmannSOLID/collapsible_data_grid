import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/static_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/table_grid_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_helper.dart';

void main() {
  var testColumns = <ColumnConfiguration>[
    ColumnConfiguration(header: const Text('Column 1')),
    ColumnConfiguration(header: const Text('Column 2')),
  ];

  testWidgets(
      'Rendering a table row with 2 columns'
      '--> Both columns get rendered and can be found', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
            columnConfigurations: testColumns,
            rowData: RowConfiguration(cells: [
              GridCellData(
                  child: const Text('Cell 1', key: Key('column1')),
                  groupKey: 1),
              GridCellData(
                  child: const Text('Cell 2', key: Key('column2')),
                  groupKey: 2),
            ]))));

    expect(find.byKey(const Key('column1')), findsOneWidget);
    expect(find.byKey(const Key('column2')), findsOneWidget);
  });

  testWidgets(
      'Rendering a table row with 2 columns and equal weights'
      '--> Both should have the same width', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
            columnConfigurations: testColumns,
            rowData: RowConfiguration(cells: [
              GridCellData(
                child: Container(
                  width: double.infinity,
                  key: const Key('column1'),
                ),
                groupKey: 1,
              ),
              GridCellData(
                child: Container(
                  width: double.infinity,
                  key: const Key('column2'),
                ),
                groupKey: 2,
              ),
            ]))));

    var col1Width = tester.getSize(find.byKey(const Key('column1'))).width;
    var col2Width = tester.getSize(find.byKey(const Key('column2'))).width;

    expect(col2Width, col1Width);
  });

  testWidgets(
      'Table with first colum weight 2 and second column weight 1'
      '--> first should be 2/3rd of the common space last should be 1/3rd',
      (tester) async {
    const screenWidth = 900.0;
    await tester.binding.setSurfaceSize(const Size(screenWidth, 640.0));
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
          columnConfigurations: <ColumnConfiguration>[
            ColumnConfiguration(header: Container(), weight: 2),
            ColumnConfiguration(header: Container(), weight: 1),
          ],
          rowData: RowConfiguration(
            cells: [
              GridCellData(
                child: Container(
                  width: double.infinity,
                  key: const Key('column1'),
                ),
                groupKey: 1,
              ),
              GridCellData(
                child: Container(
                  width: double.infinity,
                  key: const Key('column2'),
                ),
                groupKey: 2,
              ),
            ],
          ),
        ),
      ),
    );

    expect(tester.getElementWidth(const Key('column1')), (screenWidth / 3) * 2);
    expect(tester.getElementWidth(const Key('column2')), (screenWidth / 3));
  });

  testWidgets(
      'Taping/clicking a row '
      '--> Tap handler will be called ', (tester) async {
    bool wasTapped = false;
    await tester.pumpWidget(
      StaticTableRow(
        columnConfigurations: testColumns,
        rowData: RowConfiguration(onTap: (context) => wasTapped = true, cells: [
          GridCellData(
              child: const Text('Cell 1', key: Key('column1')), groupKey: 1),
          GridCellData(
              child: const Text('Cell 2', key: Key('column2')), groupKey: 2),
        ]),
      ).wrapDirectional(),
    );

    await tester.tap(find.byType(StaticTableRow));

    expect(wasTapped, true);
  });

  testWidgets(
      'Having a row where the first cell is a two coloumn span cell '
      '-->  the width of the first cell is double as of the second ',
      (tester) async {
    const screenWidth = 900.0;
    await tester.binding.setSurfaceSize(const Size(screenWidth, 640.0));
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
            columnConfigurations: <ColumnConfiguration>[
              ColumnConfiguration(header: Container(), weight: 1),
              ColumnConfiguration(header: Container(), weight: 1),
              ColumnConfiguration(header: Container(), weight: 1),
            ],
            rowData: RowConfiguration(cells: [
              GridCellData(
                colSpan: 2,
                child: Container(
                  width: double.infinity,
                  key: const Key('column1'),
                ),
                groupKey: 1,
              ),
              GridCellData(
                child: Container(
                  width: double.infinity,
                  key: const Key('column2'),
                ),
                groupKey: 2,
              ),
            ]))));

    expect(tester.getElementWidth(const Key('column1')), (screenWidth / 3) * 2);
    expect(tester.getElementWidth(const Key('column2')), (screenWidth / 3));
  });

  testWidgets(
      'Creating a table row with red backgorund color '
      '--> Color gets subitted to the table grid cell ', (tester) async {
    await tester.pumpWidget(
      StaticTableRow(
        background: Colors.red,
        columnConfigurations: testColumns,
        rowData: RowConfiguration(cells: [
          RowConfiguration(cells: [1])
        ]),
      ).wrapDirectional(),
    );

    var tableGridCell =
        tester.firstWidget<TableGridCell>(find.byType(TableGridCell));
    expect(tableGridCell.background, Colors.red);
  });
}

extension ColumnTestHelper on WidgetTester {
  double getElementWidth(Key key) => getSize(find.byKey(key)).width;
}
