import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:collapsible_data_grid/src/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Pumping a table header with 3 column configurations'
      '--> Contains a row with 3 children', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TableHeader(
          columns: [
            ColumnConfiguration(header: const Text('Column 1')),
            ColumnConfiguration(header: const Text('Column 2')),
            ColumnConfiguration(header: const Text('Column 3'))
          ],
        ),
      ).addThemeProvider(),
    );

    final row = tester.widget<Row>(find.byType(Row));

    expect(row.children.length, 3);
  });

  testWidgets(
      'Pumping a table header with 3 column configurations'
      '--> Children content will be rendered', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TableHeader(
          columns: [
            ColumnConfiguration(header: const Text('Column 1')),
            ColumnConfiguration(header: const Text('Column 2')),
            ColumnConfiguration(header: const Text('Column 3'))
          ],
        ),
      ).addThemeProvider(),
    );

    expect(find.text('Column 1'), findsOneWidget);
    expect(find.text('Column 2'), findsOneWidget);
    expect(find.text('Column 3'), findsOneWidget);
  });

  testWidgets(
      'Pumping a single column header width a column sepcific border configuration'
      '--> Border should be rendered', (tester) async {
    var dummy = const Text('Column 1');
    await tester.pumpWidget(
      MaterialApp(
        home: TableHeader(
          columns: [
            ColumnConfiguration(
              header: dummy,
            ),
          ],
        ),
      ).addThemeProvider(
        collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
          headerTheme: DecoratedCellThemeData(
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

    var headerContainer = tester.firstWidget<Container>(find.descendant(
        of: find.byType(Row), matching: find.byType(Container)));
    var cellBorder =
        (headerContainer.decoration as BoxDecoration).border as Border;

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
      'Creating a table header with theme configuration'
      '--> The theme configuration should be applied to the header cells',
      (tester) async {
    var dummy = const Text('Column 1');
    await tester.pumpWidget(
      MaterialApp(
        home: TableHeader(
          columns: [
            ColumnConfiguration(
              header: dummy,
            ),
          ],
        ),
      ).addThemeProvider(
        collapsibleDataGridThemeData: CollapsibleDataGridThemeData(
          headerTheme: DecoratedCellThemeData(
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

    var headerContainer = tester.firstWidget<Container>(find.descendant(
        of: find.byType(Row), matching: find.byType(Container)));
    var cellBorder =
        (headerContainer.decoration as BoxDecoration).border as Border;

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
      'Pumping a table header with a background themed to blue'
      '--> the header cells will be displayed with the blue background',
      (tester) async {
    var dummy = const Text('Column 1');
    await tester.pumpWidget(
      Provider(
        create: (context) => CollapsibleDataGridThemeData(
          headerTheme: DecoratedCellThemeData(
              tableBackground: TableColorProperty(mainColor: Colors.blue)),
        ),
        builder: (context, child) => MaterialApp(
          home: TableHeader(
            columns: [
              ColumnConfiguration(
                header: dummy,
              ),
            ],
          ),
        ),
      ).addThemeProvider(),
    );

    var headerCell = tester.widget<Container>(find.descendant(
        of: find.byType(DecoratedCell), matching: find.byType(Container)));
    var deco = headerCell.decoration as BoxDecoration;
    expect(deco.color, Colors.blue);
  });
}
