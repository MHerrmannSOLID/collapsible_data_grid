import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/widgets/decorated_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const column1_key = Key('Column 1');
const column2_key = Key('Column 2');
const cell1_key = Key('Cell 1');
const cell2_key = Key('Cell 2');
const cell3_key = Key('Cell 3');
const cell4_key = Key('Cell 4');

Widget _createTestTable() {
  var testColumns = <ColumnConfiguration>[
    ColumnConfiguration(header: const Text('Column 1', key: column1_key)),
    ColumnConfiguration(
        header: const Text(
      'Column 2',
      key: column2_key,
    )),
  ];
  return CollapsibleDataGrid(
    columnConfigurations: testColumns,
    rowConfigurations: [
      RowConfiguration(cells: [
        GridCellData(
            child: const Text('Cell 1', key: cell1_key), groupKey: 'Cell 1'),
        GridCellData(
            child: const Text(
              'Cell 2',
              key: cell2_key,
            ),
            groupKey: 'Cell 2'),
      ]),
      RowConfiguration(
        cells: [
          GridCellData(
              child: const Text('Cell 3', key: cell3_key), groupKey: 'Cell 3'),
          GridCellData(
              child: const Text(
                'Cell 4',
                key: cell4_key,
              ),
              groupKey: 'Cell 4'),
        ],
      ),
    ],
    controller: CollapsibleGridController(),
  );
}

void main() {
  group('Default settings when there is no theme information at all.', () {
    testWidgets(
        'Validation of the default cell background color'
        ' --> Cell Background should be transparent', (tester) async {
      await tester.pumpWidget(
        //https://api.flutter.dev/flutter/material/ThemeExtension-class.html
        MaterialApp(
            theme: ThemeData.light()
                .copyWith(extensions: <ThemeExtension<dynamic>>[
              CollapsibleDataGridThemeData(),
            ]),
            home: _createTestTable()),
      );

      var restr = tester
          .element(find.byKey(cell1_key))
          .findAncestorWidgetOfExactType<Container>();

      var deco = restr?.decoration as BoxDecoration;
      expect(deco.color, Colors.transparent);
    });

    testWidgets(
        'Pumping a grid with no theme data available'
        ' --> Fallback to default border configuration', (tester) async {
      await tester.pumpWidget(
        //https://api.flutter.dev/flutter/material/ThemeExtension-class.html
        MaterialApp(
            theme: ThemeData.light()
                .copyWith(extensions: <ThemeExtension<dynamic>>[
              CollapsibleDataGridThemeData(),
            ]),
            home: _createTestTable()),
      );

      var cellContainer = tester
          .element(find.byKey(cell1_key))
          .findAncestorWidgetOfExactType<DecoratedCell>();

      var container = tester.firstWidget(find.descendant(
          of: find.byWidget(cellContainer as DecoratedCell),
          matching: find.byType(Container))) as Container;

      var borderConf = (container.decoration as BoxDecoration).border as Border;

      expect(borderConf.bottom, CellBorderConfiguration().bottomBorder);
      expect(borderConf.top, CellBorderConfiguration().topBorder);
      expect(borderConf.left, CellBorderConfiguration().leftBorder);
      expect(borderConf.right, CellBorderConfiguration().rightBorder);
    });
  });
}
