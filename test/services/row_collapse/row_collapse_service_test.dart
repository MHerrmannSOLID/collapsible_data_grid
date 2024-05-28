import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/services/row_collapse/row_collapse_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dummyCollapseReturn = [
    GridCellData<num>(child: const Placeholder(), groupKey: 1, colSpan: 1)
  ];
  test(
      'Trying to fold non foldable rows'
      '--> should not call the collapseHeaderBuilder', () {
    bool hasAnyFoldedRow = false;

    var serviceUnderTest = RowCollapseService(
      collapseHeaderBuilder: (rows) {
        hasAnyFoldedRow = true;
        return dummyCollapseReturn;
      },
      rowConfigurations: [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [3, 4, 5]),
        RowConfiguration<num>(cells: [6, 7, 7]),
      ],
    );

    serviceUnderTest.foldRowsBy(columnIdx: 0);

    expect(hasAnyFoldedRow, isFalse);
  });

  test(
      'Trying to fold foldable rows at the'
      '--> should call the collapseHeaderBuilder', () {
    bool hasAnyFoldedRow = false;

    var serviceUnderTest = RowCollapseService(
      collapseHeaderBuilder: (rows) {
        hasAnyFoldedRow = true;
        return dummyCollapseReturn;
      },
      rowConfigurations: [
        RowConfiguration<num>(cells: [1, 2, 3]),
        RowConfiguration<num>(cells: [3, 4, 5]),
        RowConfiguration<num>(cells: [3, 7, 7]),
      ],
    );

    serviceUnderTest.foldRowsBy(columnIdx: 0);

    expect(hasAnyFoldedRow, isTrue);
    expect(serviceUnderTest.collapedRows.last is ExpandableRow, isTrue);
  });

  test(
      'Trying to fold the special case where the first row is foldbale'
      '--> First element should be expadable row', () {
    var serviceUnderTest = RowCollapseService(
      collapseHeaderBuilder: (rows) {
        return dummyCollapseReturn;
      },
      rowConfigurations: [
        RowConfiguration<num>(cells: [3, 2, 3]),
        RowConfiguration<num>(cells: [3, 4, 5]),
        RowConfiguration<num>(cells: [2, 7, 7]),
      ],
    );

    serviceUnderTest.foldRowsBy(columnIdx: 0);

    expect(serviceUnderTest.collapedRows.first is ExpandableRow, isTrue);
  });
}
