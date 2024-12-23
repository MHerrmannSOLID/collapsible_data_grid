import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/widgets/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/static_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_helper.dart';

void main() {
  group('Collapssible data grid creation tests', () {
    var testColumns = <ColumnConfiguration>[
      ColumnConfiguration(header: const Text('Column 1')),
      ColumnConfiguration(header: const Text('Column 2')),
    ];

    testWidgets(
        'Create an empty flex table '
        '--> should contain a table header widget.', (tester) async {
      await tester.pumpWidget(CollapsibleDataGrid(
        columnConfigurations: [],
        rowConfigurations: [],
        controller: CollapsibleGridController(),
      ).wrapDirectional());

      expect(find.byType(TableHeader), findsOneWidget);
    });

    testWidgets(
        'Create flex table with 3 rows '
        '--> should contain a list view with 3 children.', (tester) async {
      await tester.pumpWidget(CollapsibleDataGrid(
        columnConfigurations: testColumns,
        rowConfigurations: [
          RowConfiguration(cells: [
            GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1'),
            GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 2'),
          ]),
          RowConfiguration(
            cells: [
              GridCellData(child: const Text('Cell 3'), groupKey: 'Cell 3'),
              GridCellData(child: const Text('Cell 4'), groupKey: 'Cell 4'),
            ],
          ),
          RowConfiguration(
            cells: [
              GridCellData(child: const Text('Cell 5'), groupKey: 'Cell 5'),
              GridCellData(child: const Text('Cell 6'), groupKey: 'Cell 6'),
            ],
          ),
        ],
        controller: CollapsibleGridController(),
      ).wrapDirectional());
      await tester.pumpAndSettle();

      var listView = tester.firstWidget<ListView>(find.byType(ListView));

      expect(listView.semanticChildCount, 3);
    });

    testWidgets(
        'Create flex table with 3 static rows '
        '--> should find 3 static table rows.', (tester) async {
      await tester.pumpWidget(CollapsibleDataGrid(
        columnConfigurations: testColumns,
        rowConfigurations: [
          RowConfiguration(cells: [
            GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1'),
            GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 2'),
          ]),
          RowConfiguration(
            cells: [
              GridCellData(child: const Text('Cell 3'), groupKey: 'Cell 3'),
              GridCellData(child: const Text('Cell 4'), groupKey: 'Cell 4'),
            ],
          ),
          RowConfiguration(
            cells: [
              GridCellData(child: const Text('Cell 5'), groupKey: 'Cell 5'),
              GridCellData(child: const Text('Cell 6'), groupKey: 'Cell 6'),
            ],
          ),
        ],
        controller: CollapsibleGridController(),
      ).wrapDirectional());

      expect(find.byType(StaticTableRow), findsNWidgets(3));
    });

    testWidgets(
        'Create flex table with 1 expandable row '
        '--> should find an expandable row.', (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          columnConfigurations: testColumns,
          rowConfigurations: [
            RowConfiguration(cells: [
              GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1'),
              GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 2'),
            ]),
            ExpandableRow(
              cells: [
                GridCellData<String>(
                    child: const Text('Cell 3'), groupKey: 'Cell 3'),
                GridCellData<String>(
                    child: const Text('Cell 4'), groupKey: 'Cell 4'),
              ],
              children: [
                RowConfiguration(cells: [
                  GridCellData(child: const Text('Cell 5'), groupKey: 'Cell 5'),
                  GridCellData(child: const Text('Cell 6'), groupKey: 'Cell 6'),
                ]),
              ],
            ),
            RowConfiguration(
              cells: [
                GridCellData(child: const Text('Cell 7'), groupKey: 'Cell 7'),
                GridCellData(child: const Text('Cell 8'), groupKey: 'Cell 8'),
              ],
            ),
          ],
          controller: CollapsibleGridController(),
        ),
      ).wrapDirectional());

      expect(find.byType(ExpandableTableRow), findsOneWidget);
    });

    testWidgets(
        'Create a pre foded table having one expandable row '
        '--> There should be an expandable row rendered.', (tester) async {
      await tester.pumpWidget(Material(
        child: CollapsibleDataGrid(
          columnConfigurations: testColumns,
          rowConfigurations: [
            RowConfiguration(cells: [1, 1]),
            RowConfiguration(cells: [2, 2]),
            RowConfiguration(cells: [3, 2]),
            RowConfiguration(cells: [4, 2]),
            RowConfiguration(cells: [5, 3]),
          ],
          controller: CollapsibleGridController(),
          collapseByColumn: 1,
        ),
      ).wrapDirectional());

      expect(find.byType(ExpandableTableRow), findsNWidgets(1));
    });
  });
}
