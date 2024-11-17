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
            return Placeholder();
          },
        ),
      ).wrapDirectional(
        collapsibleDataGridThemeData: tableTheme,
      ),
    );
    expect(deliveredTheme, same(tableTheme));
  });
}
