import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/types/theme/decorated_cell_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
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
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
          columnConfigurations: testColumns,
          rowData: RowConfiguration(
            cells: [
              GridCellData(
                  child: const Text('Cell 1', key: Key('column1')),
                  groupKey: 1),
              GridCellData(
                  child: const Text('Cell 2', key: Key('column2')),
                  groupKey: 2),
            ],
          ),
        ),
      ).addThemeProvider(),
    );

    expect(find.byKey(const Key('column1')), findsOneWidget);
    expect(find.byKey(const Key('column2')), findsOneWidget);
  });

  testWidgets(
      'Rendering a table row with 2 columns and equal weights'
      '--> Both should have the same width', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
          columnConfigurations: testColumns,
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
      ).addThemeProvider(),
    );

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
      ).addThemeProvider(),
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
      ).wrapDirectional().addThemeProvider(),
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
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StaticTableRow(
          columnConfigurations: <ColumnConfiguration>[
            ColumnConfiguration(header: Container(), weight: 1),
            ColumnConfiguration(header: Container(), weight: 1),
            ColumnConfiguration(header: Container(), weight: 1),
          ],
          rowData: RowConfiguration(
            cells: [
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
            ],
          ),
        ),
      ).addThemeProvider(),
    );

    expect(tester.getElementWidth(const Key('column1')), (screenWidth / 3) * 2);
    expect(tester.getElementWidth(const Key('column2')), (screenWidth / 3));
  });

  testWidgets(
      'Creating a table row with red backgorund color '
      '--> Color gets subitted to the table grid cell ', (tester) async {
    await tester.pumpWidget(
      StaticTableRow(
        columnConfigurations: testColumns,
        rowData: RowConfiguration(cells: [
          RowConfiguration(cells: [1.toString()])
        ]),
      ).wrapDirectional().addThemeProvider(
            collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
              cellTheme: DecoratedCellThemeData(
                tableBackground: TableColorProperty(mainColor: Colors.red),
              ),
            ),
          ),
    );

    var tableGridCell = tester.firstWidget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var tableGridCellDecoration = tableGridCell.decoration as BoxDecoration;
    expect(tableGridCellDecoration.color, Colors.red);
  });

  testWidgets(
      'Creating a table row with red with border decoration '
      '--> Border decoration gets subitted to the table grid cell ',
      (tester) async {
    await tester.pumpWidget(
      StaticTableRow(
        columnConfigurations: testColumns,
        rowData: RowConfiguration(cells: [
          RowConfiguration(cells: [1])
        ]),
      ).wrapDirectional().addThemeProvider(
            collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
              cellTheme: DecoratedCellThemeData(
                tableBackground: TableColorProperty(mainColor: Colors.lime),
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

    var tableGridCell =
        tester.firstWidget<TableGridCell>(find.byType(TableGridCell));
    var cell = tester.firstWidget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var decoration = cell.decoration as BoxDecoration;
    var cellBorder = decoration.border as Border;

    expect(decoration.color, Colors.lime);
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

extension ColumnTestHelper on WidgetTester {
  double getElementWidth(Key key) => getSize(find.byKey(key)).width;
}
