import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing initializaton of CollapsibleGridController ', () {
    final defaultTestColumns = [
      'Column 1',
      'Column 2',
      'Column 3',
    ];

    test(
        'Initializing table model with string headers only'
        '--> created the Column headers automatically', () {
      var model = CollapsibleGridController();
      model.initialize([
        'Column 1',
        'Column 2',
        'Column 3',
      ], []);
      var columnConfigurations = model.columnConfigurations.toList();
      expect(columnConfigurations.length, 3);
      expect(columnConfigurations[0].header, TypeMatcher<Text>());
      expect(columnConfigurations[1].header, TypeMatcher<Text>());
      expect(columnConfigurations[2].header, TypeMatcher<Text>());
    });

    test(
        'Initializing a simple table model with string headers only'
        '--> The text of the widgts should match the string from constrution',
        () {
      var model = CollapsibleGridController();
      model.initialize([
        'Column 1',
        'Column 2',
        'Column 3',
      ], []);

      var columnConfigurations = model.columnConfigurations.toList();
      expect(columnConfigurations.length, 3);
      expect((columnConfigurations[0].header as Text).data, 'Column 1');
      expect((columnConfigurations[1].header as Text).data, 'Column 2');
      expect((columnConfigurations[2].header as Text).data, 'Column 3');
    });

    test(
        'Initializing a simple table model with widget headers only'
        '--> The text of the widgts should match the string from constrution',
        () {
      var model = CollapsibleGridController();
      model.initialize([
        const Icon(Icons.ac_unit),
        const Icon(Icons.access_alarm),
        const Icon(Icons.access_time),
      ], []);
      var columnConfigurations = model.columnConfigurations.toList();
      expect(columnConfigurations.length, 3);
      expect((columnConfigurations[0].header as Icon).icon, Icons.ac_unit);
      expect((columnConfigurations[1].header as Icon).icon, Icons.access_alarm);
      expect((columnConfigurations[2].header as Icon).icon, Icons.access_time);
    });

    test(
        'Initializing a simple table model with mixed header data'
        '--> Each column configuration will be created correctly', () {
      var model = CollapsibleGridController();
      model.initialize([
        ColumnConfiguration(
            header: TextButton(onPressed: () {}, child: Text('Column 1')),
            weight: 2),
        const Icon(Icons.access_alarm),
        'Column 3',
      ], []);

      var columnConfigurations = model.columnConfigurations.toList();
      expect(columnConfigurations.length, 3);
      expect(columnConfigurations[0].weight, 2);
      expect(
          ((columnConfigurations[0].header as TextButton).child as Text).data,
          'Column 1');
      expect((columnConfigurations[1].header as Icon).icon, Icons.access_alarm);
      expect((columnConfigurations[2].header as Text).data, 'Column 3');
    });

    test(
        'Initializing a simple table model with auto created headers only'
        '--> Weight should be distributed equally between the columns', () {
      var model = CollapsibleGridController();
      model.initialize([
        'Column 1',
        'Column 2',
        'Column 3',
      ], []);

      var columnConfigurations = model.columnConfigurations.toList();
      var commonWeight = columnConfigurations[0].weight;

      expect(columnConfigurations.length, 3);
      expect(columnConfigurations[1].weight, commonWeight);
      expect(columnConfigurations[2].weight, commonWeight);
    });

    test(
        'Initializing a table model with a cellStyleBuilder'
        '--> builder should be called for each elment', () {
      List<StyleBuilderCallData> styledCells = [];
      var model = CollapsibleGridController(
        cellStyleBuilder: (colIdx, rowIdx, toStyle) => styledCells.add(
          StyleBuilderCallData(colIdx, rowIdx, toStyle),
        ),
      );

      model.initialize(defaultTestColumns, [
        RowConfiguration<String>(cells: ['1', '2', '3']),
        RowConfiguration<String>(cells: ['4', '5', '6']),
      ]);

      expect(styledCells.length, 6);
    });

    test(
        'Initializing a table model with a cellStyleBuilder'
        '--> row and column index are supplied correctly', () {
      List<StyleBuilderCallData> styledCells = [];
      var model = CollapsibleGridController(
        cellStyleBuilder: (colIdx, rowIdx, toStyle) => styledCells.add(
          StyleBuilderCallData(colIdx, rowIdx, toStyle),
        ),
      );

      model.initialize(defaultTestColumns, [
        RowConfiguration<String>(cells: ['1', '2', '3']),
        RowConfiguration<String>(cells: ['4', '5', '6']),
      ]);

      expect(styledCells.findFirstWithText("1").rowIdx, 0);
      expect(styledCells.findFirstWithText("1").colIdx, 0);
      expect(styledCells.findFirstWithText("3").rowIdx, 0);
      expect(styledCells.findFirstWithText("3").colIdx, 2);
      expect(styledCells.findFirstWithText("5").rowIdx, 1);
      expect(styledCells.findFirstWithText("5").colIdx, 1);
    });

    test(
        'Reinitialize the table model with the same data'
        '--> Initialize should keep the inner state since data did not change',
        () {
      var model = CollapsibleGridController();
      var rowConfigurations = [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 8, 9]),
      ];

      //initially we have 3 rows since we did not collapse the model
      model.initialize(defaultTestColumns, rowConfigurations);
      expect(model.rowConfigurations.length, 3);

      //here we change the inner state. Due to the collapsing row count will be 2
      model.collapseColumn(columnIdx: 1);
      expect(model.rowConfigurations.length, 2);

      //since we reinitailize the model with the same data, the row count should remain unchanged --> 2
      model.initialize(defaultTestColumns, rowConfigurations);
      expect(model.rowConfigurations.length, 2);
    });

    test(
        'Reinitialize the table model with different data'
        '--> Inner state will be resetted due to change of data', () {
      var model = CollapsibleGridController();
      var rowConfigurationsFirst = [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [7, 8, 9]),
      ];
      var rowConfigurationsSecond = [
        RowConfiguration<num>(cells: [7, 2, 3]),
        RowConfiguration<num>(cells: [4, 8, 6]),
        RowConfiguration<num>(cells: [1, 8, 9]),
      ];

      //initially we have 3 rows since we did not collapse the model
      model.initialize(defaultTestColumns, rowConfigurationsFirst);
      expect(model.rowConfigurations.length, 3);

      //here we change the inner state. Due to the collapsing row count will be 2
      model.collapseColumn(columnIdx: 1);
      expect(model.rowConfigurations.length, 2);

      //since we reinitailize the model with the same data, the row count should remain unchanged --> 2
      model.initialize(defaultTestColumns, rowConfigurationsSecond);
      expect(model.rowConfigurations.length, 3);
    });

    test(
        'Initilzing a simple table model with a single row'
        '--> Row count should be 1', () {
      var model = CollapsibleGridController();
      model.initialize(defaultTestColumns, [
        RowConfiguration<num>(cells: [1, 2, 3])
      ]);
      expect(model.rowConfigurations.length, 1);
    });
  });
}

class StyleBuilderCallData {
  final int colIdx;
  final int rowIdx;
  final GridCellData toStyle;

  StyleBuilderCallData(this.colIdx, this.rowIdx, this.toStyle);

  bool hasText(String text) {
    if (toStyle.child is! Text) return false;
    return (toStyle.child as Text).data == text;
  }
}

extension StyleBuilderCallDataFinder on List<StyleBuilderCallData> {
  StyleBuilderCallData findFirstWithText(String text) =>
      firstWhere((element) => element.hasText(text));
}
