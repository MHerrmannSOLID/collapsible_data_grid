import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/collapsible_data_grid_theme_data.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

main() {
  testWidgets(
      'Query the current theme with the stat "of" method  '
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
      'Query the current theme with the stat "of" method  '
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

  test(
      'Creation of the CollapsibleDataGridThemeData '
      ' --> will be created with a default CellBorderConfiguration,'
      ' if not defined differently.', () {
    var testConfig = CollapsibleDataGridThemeData();

    expect(testConfig.dataCellDecoration, const CellBorderConfiguration());
  });

  test(
      'Creation of the CollapsibleDataGridThemeData with red bottom border'
      ' --> will prefer the given decoration.', () {
    var testConfig = CollapsibleDataGridThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
    );

    expect(testConfig.dataCellDecoration.bottomBorder.color, Colors.red);
  });

  test(
      'Creation of the CollapsibleDataGridThemeData '
      ' --> wil create a transparent background by default.', () {
    var testConfig = CollapsibleDataGridThemeData();

    var tableBackground = testConfig.tableBackground.resolve({});
    expect(tableBackground, Colors.transparent);
  });

  test(
      'Creation of the CollapsibleDataGridThemeData with red background'
      ' --> will prefer the given background.', () {
    var testConfig = CollapsibleDataGridThemeData(
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var tableBackground = testConfig.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a CollapsibleDataGridThemeData'
      ' --> copy exactly resambles the original', () {
    var testConfig = CollapsibleDataGridThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith() as CollapsibleDataGridThemeData;

    expect(copy.dataCellDecoration.bottomBorder.color, Colors.red);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a CollapsibleDataGridThemeData with grenn bottom boder'
      ' --> copy exactly resambles the original', () {
    var testConfig = CollapsibleDataGridThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.green),
      ),
    ) as CollapsibleDataGridThemeData;

    expect(copy.dataCellDecoration.bottomBorder.color, Colors.green);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a CollapsibleDataGridThemeData with green cell backgorund'
      ' --> copy exactly resambles the original', () {
    var testConfig = CollapsibleDataGridThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith(
      tableBackground: TableColorProperty(mainColor: Colors.green),
    ) as CollapsibleDataGridThemeData;

    expect(copy.dataCellDecoration.bottomBorder.color, Colors.red);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.green);
  });

  test(
      'lerp tableBackground between two dfined RGB values'
      ' --> results as given values', () {
    var conf1 = CollapsibleDataGridThemeData(
      tableBackground:
          TableColorProperty(mainColor: Color.fromARGB(205, 100, 50, 0)),
    );
    var conf2 = CollapsibleDataGridThemeData(
      tableBackground:
          TableColorProperty(mainColor: Color.fromARGB(255, 50, 150, 200)),
    );

    var lerp = conf1.lerp(conf2, 0.5) as CollapsibleDataGridThemeData;

    var tableBackground = lerp.tableBackground.resolve({});
    expect(tableBackground, Color.fromARGB(230, 75, 100, 100));
  });
}
