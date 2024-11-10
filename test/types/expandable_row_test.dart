import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

List<GridCellData> _getDummyRow() => [
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
    ];

main() {
  test(
      'Creation of an expandable row --> '
      ' "getCells()" will provide the "cells" delivered in the constuctor', () {
    var testCells = _getDummyRow();

    var testRow = ExpandableRow(cells: testCells, children: []);

    expect(testRow.getCells(), equals(testCells));
  });

  test(
      'Creation of an expandable row --> '
      ' "getCells()" and cellData are identical', () {
    var testCells = _getDummyRow();

    var testRow = ExpandableRow(cells: testCells, children: []);

    expect(testRow.getCells(), same(testRow.cellsData));
  });

  test(
      'Creation of an expandable row --> '
      ' "cellsData" will provide the "cells" delivered in the constuctor', () {
    var testCells = _getDummyRow();

    var testRow = ExpandableRow(cells: testCells, children: []);

    expect(testRow.getCells(), equals(testCells));
  });

  test(
      'Creation of an expandable row --> '
      ' "isExpandable" will be true', () {
    var testCells = _getDummyRow();

    var testRow = ExpandableRow(cells: testCells, children: []);

    expect(testRow.isExpandable, isTrue);
  });

  test(
      'Creation of an expandable row --> '
      ' Uses default number format inf nothing else is provided', () {
    var testCells = _getDummyRow();

    var testRow = ExpandableRow(cells: testCells, children: []);

    expect(testRow.numberFormat, equals(RowConfiguration.defaultNumberFormat));
  });

  test(
      'Creation of an expandable row --> '
      ' uses own number format over default format if provided', () {
    var testCells = _getDummyRow();
    var ownFormat = NumberFormat.currency(locale: 'de_DE', name: '€');

    var testRow =
        ExpandableRow(cells: testCells, children: [], numberFormat: ownFormat);

    expect(testRow.numberFormat, equals(ownFormat));
    expect(testRow.numberFormat, isNot(RowConfiguration.defaultNumberFormat));
  });

  test(
      'Creation of an expandable row --> '
      ' uses own "ExpandableController" over default controller if provided',
      () {
    var testCells = _getDummyRow();
    var ownController = TestExpandableController();

    var testRow = ExpandableRow(
        cells: testCells, children: [], controller: ownController);

    expect(testRow.controller, equals(ownController));
  });
}

class TestExpandableController extends ExpandableController {}
