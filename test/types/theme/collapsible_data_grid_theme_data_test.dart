import 'dart:math';

import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/theme/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

main() {
  testWidgets(
      'Query the current theme with the static "of" method  '
      '--> getting a valid theme instance .', (tester) async {
    CollapsibleDataGridThemeData? tableTheme = null;
    await tester.pumpWidget(
      Material(
        child: StatefulBuilder(
          builder: (context, setState) {
            tableTheme = CollapsibleDataGridThemeData.of(context);
            return Placeholder();
          },
        ),
      ).wrapDirectional(
        collapsibleDataGridThemeData: CollapsibleDataGridThemeData(),
      ),
    );
    expect(tableTheme, isNotNull);
  });

  testWidgets(
      'Query the current theme with the static "of" method  '
      '--> returns eactly the same theme as injected .', (tester) async {
    CollapsibleDataGridThemeData? deliveredTheme = null;
    var tableTheme = CollapsibleDataGridThemeData();
    await tester.pumpWidget(
      Material(
        child: StatefulBuilder(
          builder: (context, setState) {
            deliveredTheme = CollapsibleDataGridThemeData.of(context);
            return const Placeholder();
          },
        ),
      ).wrapDirectional(
        collapsibleDataGridThemeData: tableTheme,
      ),
    );
    expect(deliveredTheme, same(tableTheme));
  });

  test(
      'Create a copy with a new cellTheme'
      ' --> the copy should contain the new cellTheme', () {
    var oldTheme = DecoratedCellThemeData();
    var mewTheme = DecoratedCellThemeData(
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var tableTheme = CollapsibleDataGridThemeData(cellTheme: oldTheme);

    var copy = tableTheme.copyWith(cellTheme: mewTheme)
        as CollapsibleDataGridThemeData;

    expect(copy.cellTheme, same(mewTheme));
    expect(copy.cellTheme, isNot(same(oldTheme)));
  });

  test(
      'Create a copy with a new headerTheme'
      ' --> the copy should contain the new headerTheme', () {
    var oldTheme = DecoratedCellThemeData();
    var mewTheme = DecoratedCellThemeData(
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var tableTheme = CollapsibleDataGridThemeData(headerTheme: oldTheme);

    var copy = tableTheme.copyWith(headerTheme: mewTheme)
        as CollapsibleDataGridThemeData;

    expect(copy.headerTheme, same(mewTheme));
    expect(copy.headerTheme, isNot(same(oldTheme)));
  });

  test(
      'Request linear interpolation between two themes'
      ' --> "lerp" will be called for cellTheme and headerTheme', () {
    var mockCellTheme = DecoratedCellThemeLerpMock();
    var mockHeaderTheme = DecoratedCellThemeLerpMock();
    var oldTheme = CollapsibleDataGridThemeData(
        cellTheme: mockCellTheme, headerTheme: mockHeaderTheme);
    var newTheme = CollapsibleDataGridThemeData(
      cellTheme: DecoratedCellThemeData(
        tableBackground: TableColorProperty(mainColor: Colors.green),
      ),
      headerTheme: DecoratedCellThemeData(
        tableBackground: TableColorProperty(mainColor: Colors.red),
      ),
    );

    var result = oldTheme.lerp(newTheme, 0.15) as CollapsibleDataGridThemeData;

    expect(mockCellTheme.other, newTheme.cellTheme);
    expect(mockCellTheme.t, 0.15);
    expect(mockHeaderTheme.other, newTheme.headerTheme);
    expect(mockHeaderTheme.t, 0.15);
  });
}

class DecoratedCellThemeLerpMock extends Fake
    implements DecoratedCellThemeData {
  ThemeExtension<DecoratedCellThemeData>? other;
  double? t;

  @override
  ThemeExtension<DecoratedCellThemeData> lerp(
      covariant ThemeExtension<DecoratedCellThemeData>? other, double t) {
    this.other = other;
    this.t = t;
    return other!;
  }
}
