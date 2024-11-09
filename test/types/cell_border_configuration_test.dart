import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ///********************************************
  /// NOTE:
  ///
  ///All tests are ignoring the 'prefer_const_constructors'
  ///rule.
  ///That is due to the fact, that if we would work with
  ///const objects, the equality would not fall back
  ///to the equality operator overrride, but would rahter
  ///be directly solved by the runtime.
  ///Or in other words the part that we would like to test
  ///would be bypassed ba the runtime in case of const declatation.
  ///********************************************/

  test(
      'Comparing identical non const CellBorderConfigurations '
      ' --> they should be recogniced as equal', () {
    // ignore: prefer_const_constructors
    var conf1 = CellBorderConfiguration(
        // ignore: prefer_const_constructors
        bottomBorder: BorderSide(
            color: Colors.lightBlueAccent,
            strokeAlign: BorderSide.strokeAlignOutside,
            width: 12),
        // ignore: prefer_const_constructors
        rightBorder: BorderSide(
            width: 1, color: Colors.black26, style: BorderStyle.solid),
        leftBorder:
            // ignore: prefer_const_constructors
            BorderSide(strokeAlign: BorderSide.strokeAlignInside, width: 11));
    var conf2 = conf1;

    expect(conf1 == conf2, isTrue);
  });

  test(
      'Comparing two equal (non const) CellBorderConfigurations '
      ' --> they should be recogniced as equal', () {
    // ignore: prefer_const_constructors
    var topBorder = BorderSide(
        color: Colors.lightBlueAccent,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: 12);
    var leftBorder =
        // ignore: prefer_const_constructors
        BorderSide(strokeAlign: BorderSide.strokeAlignInside, width: 11);
    var rightBorder =
        // ignore: prefer_const_constructors
        BorderSide(width: 1, color: Colors.black26, style: BorderStyle.solid);

    var conf1 = CellBorderConfiguration(
        bottomBorder: topBorder,
        rightBorder: rightBorder,
        leftBorder: leftBorder);
    var conf2 = CellBorderConfiguration(
        bottomBorder: topBorder,
        rightBorder: rightBorder,
        leftBorder: leftBorder);

    expect(conf1 == conf2, isTrue);
  });

  test(
      'Comparing two non equal (non const) CellBorderConfigurations '
      ' --> they should be recogniced as equal', () {
    // ignore: prefer_const_constructors
    var topBorder = BorderSide(
        color: Colors.lightBlueAccent,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: 12);
    var leftBorder =
        // ignore: prefer_const_constructors
        BorderSide(strokeAlign: BorderSide.strokeAlignInside, width: 11);
    var rightBorder =
        // ignore: prefer_const_constructors
        BorderSide(width: 1, color: Colors.black26, style: BorderStyle.solid);

    var conf1 = CellBorderConfiguration(
        bottomBorder: topBorder,
        rightBorder: rightBorder,
        leftBorder: leftBorder);
    var conf2 = CellBorderConfiguration(
        bottomBorder: topBorder,
        rightBorder: rightBorder,
        leftBorder: leftBorder);

    expect(conf1 == conf2, isTrue);
  });

  test(
      'Creation of the CellBorderConfiguration '
      ' --> Only the bottom border has an active configuration.', () {
    var testConfig = CellBorderConfiguration();

    expect(testConfig.topBorder, BorderSide.none);
    expect(testConfig.leftBorder, BorderSide.none);
    expect(testConfig.rightBorder, BorderSide.none);
    expect(testConfig.bottomBorder, isNot(BorderSide.none));
  });

  test(
      'Creation of the CellBorderConfiguration '
      ' --> Sets a gey 1px bottom border by default.', () {
    var testConfig = CellBorderConfiguration();

    expect(testConfig.bottomBorder.color, Colors.grey);
    expect(testConfig.bottomBorder.width, 1.0);
    expect(testConfig.bottomBorder.strokeAlign, BorderSide.strokeAlignInside);
    expect(testConfig.bottomBorder.style, BorderStyle.solid);
  });
}
