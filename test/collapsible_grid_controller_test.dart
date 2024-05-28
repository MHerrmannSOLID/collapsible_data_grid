import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing of CollapsibleGridController ', () {
    final defaultTestColumns = [
      'Column 1',
      'Column 2',
      'Column 3',
    ];

    test(
        'Collapsing the table model at column 1'
        '--> no change notification since data is not collapsible', () {
      var hasChanged = false;
      var model = CollapsibleGridController();
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [4, 5, 6]),
        RowConfiguration<num>(cells: [7, 8, 9]),
      ]);
      model.addListener(() => hasChanged = true);

      model.collapseColumn(columnIdx: 1);
      expect(hasChanged, false);
    });

    test(
        'Collapsing the table model at column 1'
        '--> notifies the change of the model data', () {
      var hasChanged = false;
      var model = CollapsibleGridController();
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 8, 9]),
      ]);
      model.addListener(() => hasChanged = true);

      model.collapseColumn(columnIdx: 1);
      expect(hasChanged, true);
      expect(model.rowConfigurations.last, isA<ExpandableRow>());
    });

    test(
        'Having a collapable first row, which is special since there is no previous row'
        '--> First wor should be an expanable row.', () {
      var model = CollapsibleGridController();
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 8, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 2, 9]),
      ]);

      model.collapseColumn(columnIdx: 1);
      expect(model.rowConfigurations.length, 2);
      expect(model.rowConfigurations.first, isA<ExpandableRow>());
    });

    test(
        'Collapsing the table model at column 1'
        '--> The header build should be called.', () {
      var wasHeaderBuilderCalled = false;
      var model = CollapsibleGridController(collapseHeaderBuilder: (rows) {
        wasHeaderBuilderCalled = true;
        return rows.first.cells;
      });
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 8, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 2, 9]),
      ]);

      model.collapseColumn(columnIdx: 1);
      expect(wasHeaderBuilderCalled, isTrue);
    });

    test(
        'Collapsing the table model at column 1'
        '--> The header builder result will be applied.', () {
      var model = CollapsibleGridController(
          collapseHeaderBuilder: (rows) => <GridCellData>[
                GridCellData<num>(
                    child: const Text('Test'), colSpan: 1, groupKey: 4711),
              ]);
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 8, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 2, 9]),
      ]);

      model.collapseColumn(columnIdx: 1);
      var header = model.rowConfigurations.first as ExpandableRow;
      expect(header.cells.length, 1);
      expect(header.cells.first.groupKey, 4711);
    });
  });
}
