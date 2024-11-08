import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test(
      'Creation of the CollapsibleDataGridThemeData '
      ' --> Only the bottom border has an active configuration.', () {
    var testConfig = CellBorderConfiguration();

    expect(testConfig.topBorder, BorderSide.none);
    expect(testConfig.leftBorder, BorderSide.none);
    expect(testConfig.rightBorder, BorderSide.none);
    expect(testConfig.bottomBorder, isNot(BorderSide.none));
  });

  test(
      'Creation of the CollapsibleDataGridThemeData '
      ' --> Sets a gey 1px bottom border by default.', () {
    var testConfig = CellBorderConfiguration();

    expect(testConfig.bottomBorder.color, Colors.grey);
    expect(testConfig.bottomBorder.width, 1.0);
    expect(testConfig.bottomBorder.strokeAlign, BorderSide.strokeAlignInside);
    expect(testConfig.bottomBorder.style, BorderStyle.solid);
  });
}
