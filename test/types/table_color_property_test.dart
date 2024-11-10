import 'package:collapsible_data_grid/src/types/table_color_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Creation of a color property with kjust a default color'
      ' --> will return the default color on resolve.', () {
    var testColor = TableColorProperty(mainColor: Colors.red);

    expect(testColor.resolve({}), Colors.red);
  });

  test(
      'Creation of a red color property with blue as a disabled color'
      ' --> should return red by default and blue on disaled.', () {
    var testColor = TableColorProperty(
      mainColor: Colors.red,
      stateColors: {
        {WidgetState.disabled}: Colors.blue,
      },
    );

    expect(testColor.resolve({}), Colors.red);
    expect(testColor.resolve({WidgetState.disabled}), Colors.blue);
  });

  test(
      'Creation of a red color property with blue as a disabled color'
      ' --> should return default color on different states than disabled.',
      () {
    var testColor = TableColorProperty(
      mainColor: Colors.red,
      stateColors: {
        {WidgetState.disabled}: Colors.blue,
      },
    );

    expect(testColor.resolve({}), Colors.red);
    expect(testColor.resolve({WidgetState.dragged}), Colors.red);
  });

  test(
      'Creating a table color property with combined states'
      ' --> should return the right color for each combination.', () {
    var testColor = TableColorProperty(
      mainColor: Colors.red,
      stateColors: {
        {WidgetState.disabled}: Colors.blue,
        {WidgetState.disabled, WidgetState.error}: Colors.grey,
      },
    );

    expect(testColor.resolve({}), Colors.red);
    expect(testColor.resolve({WidgetState.disabled}), Colors.blue);
    expect(testColor.resolve({WidgetState.disabled, WidgetState.error}),
        Colors.grey);
  });

  test(
      'Creating a table color property with combined states,'
      ' but orderend differntly'
      ' --> should return the right color for each combination.', () {
    var testColor = TableColorProperty(
      mainColor: Colors.red,
      stateColors: {
        {WidgetState.disabled}: Colors.blue,
        {WidgetState.disabled, WidgetState.error}: Colors.grey,
      },
    );

    expect(testColor.resolve({}), Colors.red);
    expect(testColor.resolve({WidgetState.disabled}), Colors.blue);
    expect(testColor.resolve({WidgetState.error, WidgetState.disabled}),
        Colors.grey);
  });

  test(
      'lerp(ing) inbetween two color properties just having a main color'
      ' --> having the lerp of the main color between the propertes ', () {
    var conf1 = TableColorProperty(mainColor: Color.fromARGB(205, 100, 50, 0));
    var conf2 =
        TableColorProperty(mainColor: Color.fromARGB(255, 50, 150, 200));

    var result = conf1.lerp(conf2, 0.5);

    expect(result.resolve({}), Color.fromARGB(230, 75, 100, 100));
  });

  test(
      'lerp(ing) inbetween two color properties where states as no equal'
      ' --> just starts to lerp from transparent ', () {
    var conf1 = TableColorProperty(mainColor: Color.fromARGB(205, 100, 50, 0));
    var conf2 = TableColorProperty(
        mainColor: Color.fromARGB(255, 50, 150, 200),
        stateColors: {
          {WidgetState.disabled}: Color.fromARGB(250, 50, 150, 200),
        });

    var result = conf1.lerp(conf2, 0.5);

    expect(result.resolve({}), Color.fromARGB(230, 75, 100, 100));
    expect(result.resolve({WidgetState.disabled}),
        Color.fromARGB(125, 50, 150, 200));
  });

  test(
      'lerp(ing) inbetween two color properties where states as no equal'
      ' --> just starts to lerp from transparent 2', () {
    var conf1 = TableColorProperty(
        mainColor: Color.fromARGB(205, 100, 50, 0),
        stateColors: {
          {WidgetState.disabled}: Color.fromARGB(250, 50, 150, 200),
        });
    var conf2 = TableColorProperty(
      mainColor: Color.fromARGB(255, 50, 150, 200),
    );

    var result = conf1.lerp(conf2, 0.5);

    expect(result.resolve({}), Color.fromARGB(230, 75, 100, 100));
    expect(result.resolve({WidgetState.disabled}),
        Color.fromARGB(125, 50, 150, 200));
  });

  test(
      'lerp(ing) inbetween two color properties with common states'
      ' --> just lerp(s) betweein the state colors', () {
    var conf1 = TableColorProperty(
        mainColor: Color.fromARGB(205, 100, 50, 0),
        stateColors: {
          {WidgetState.disabled}: Color.fromARGB(250, 50, 150, 200),
        });
    var conf2 = TableColorProperty(
        mainColor: Color.fromARGB(255, 50, 150, 200),
        stateColors: {
          {WidgetState.disabled}: Color.fromARGB(150, 20, 100, 220),
        });

    var result = conf1.lerp(conf2, 0.5);

    expect(result.resolve({}), Color.fromARGB(230, 75, 100, 100));
    expect(result.resolve({WidgetState.disabled}),
        Color.fromARGB(200, 35, 125, 210));
  });
}
