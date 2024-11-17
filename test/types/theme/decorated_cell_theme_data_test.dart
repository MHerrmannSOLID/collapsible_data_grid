import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:collapsible_data_grid/src/types/theme/decorated_cell_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Creation of the DecoratedCellThemeData '
      ' --> will be created with a default CellBorderConfiguration,'
      ' if not defined differently.', () {
    var testConfig = DecoratedCellThemeData();

    expect(testConfig.boderDecoration, const CellBorderConfiguration());
  });

  test(
      'Creation of the DecoratedCellThemeData with red bottom border'
      ' --> will prefer the given decoration.', () {
    var testConfig = DecoratedCellThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
    );

    expect(testConfig.boderDecoration.bottomBorder.color, Colors.red);
  });

  test(
      'Creation of the DecoratedCellThemeData '
      ' --> wil create a transparent background by default.', () {
    var testConfig = DecoratedCellThemeData();

    var tableBackground = testConfig.tableBackground.resolve({});
    expect(tableBackground, Colors.transparent);
  });

  test(
      'Creation of the DecoratedCellThemeData with red background'
      ' --> will prefer the given background.', () {
    var testConfig = DecoratedCellThemeData(
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var tableBackground = testConfig.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a DecoratedCellThemeData'
      ' --> copy exactly resambles the original', () {
    var testConfig = DecoratedCellThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith() as DecoratedCellThemeData;

    expect(copy.boderDecoration.bottomBorder.color, Colors.red);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a DecoratedCellThemeData with grenn bottom boder'
      ' --> copy exactly resambles the original', () {
    var testConfig = DecoratedCellThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.green),
      ),
    ) as DecoratedCellThemeData;

    expect(copy.boderDecoration.bottomBorder.color, Colors.green);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.red);
  });

  test(
      'Creating a copy of a DecoratedCellThemeData with green cell backgorund'
      ' --> copy exactly resambles the original', () {
    var testConfig = DecoratedCellThemeData(
      dataCellDecoration: const CellBorderConfiguration(
        bottomBorder: BorderSide(color: Colors.red),
      ),
      tableBackground: TableColorProperty(mainColor: Colors.red),
    );

    var copy = testConfig.copyWith(
      tableBackground: TableColorProperty(mainColor: Colors.green),
    ) as DecoratedCellThemeData;

    expect(copy.boderDecoration.bottomBorder.color, Colors.red);
    var tableBackground = copy.tableBackground.resolve({});
    expect(tableBackground, Colors.green);
  });

  test(
      'lerp tableBackground between two dfined RGB values'
      ' --> results as given values', () {
    var conf1 = DecoratedCellThemeData(
      tableBackground:
          TableColorProperty(mainColor: Color.fromARGB(205, 100, 50, 0)),
    );
    var conf2 = DecoratedCellThemeData(
      tableBackground:
          TableColorProperty(mainColor: Color.fromARGB(255, 50, 150, 200)),
    );

    var lerp = conf1.lerp(conf2, 0.5) as DecoratedCellThemeData;

    var tableBackground = lerp.tableBackground.resolve({});
    expect(tableBackground, Color.fromARGB(230, 75, 100, 100));
  });
}
