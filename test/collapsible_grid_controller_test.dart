import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final defaultTestColumns = [
    'Column 1',
    'Column 2',
    'Column 3',
  ];

  test(
      'Creating a simple table model with string headers only'
      '--> created the Column headers automatically', () {
    var model = CollapsibleGridController<num>(columnConfigurations: [
      'Column 1',
      'Column 2',
      'Column 3',
    ], rowConfigurations: []);

    expect(model.columnConfigurations.length, 3);
    expect(model.columnConfigurations[0].header, TypeMatcher<Text>());
    expect(model.columnConfigurations[1].header, TypeMatcher<Text>());
    expect(model.columnConfigurations[2].header, TypeMatcher<Text>());
  });

  test(
      'Creating a simple table model with string headers only'
      '--> The text of the widgts should match the string from constrution',
      () {
    var model = CollapsibleGridController<num>(columnConfigurations: [
      'Column 1',
      'Column 2',
      'Column 3',
    ], rowConfigurations: []);

    expect(model.columnConfigurations.length, 3);
    expect((model.columnConfigurations[0].header as Text).data, 'Column 1');
    expect((model.columnConfigurations[1].header as Text).data, 'Column 2');
    expect((model.columnConfigurations[2].header as Text).data, 'Column 3');
  });

  test(
      'Creating a simple table model with widget headers only'
      '--> The text of the widgts should match the string from constrution',
      () {
    var model = CollapsibleGridController<num>(columnConfigurations: [
      const Icon(Icons.ac_unit),
      const Icon(Icons.access_alarm),
      const Icon(Icons.access_time),
    ], rowConfigurations: []);

    expect(model.columnConfigurations.length, 3);
    expect((model.columnConfigurations[0].header as Icon).icon, Icons.ac_unit);
    expect((model.columnConfigurations[1].header as Icon).icon,
        Icons.access_alarm);
    expect(
        (model.columnConfigurations[2].header as Icon).icon, Icons.access_time);
  });

  test(
      'Creating a simple table model with mixed header data'
      '--> Each column configuration will be created correctly', () {
    var model = CollapsibleGridController<num>(columnConfigurations: [
      ColumnConfiguration(
          header: TextButton(onPressed: () {}, child: Text('Column 1')),
          weight: 2),
      const Icon(Icons.access_alarm),
      'Column 3',
    ], rowConfigurations: []);

    expect(model.columnConfigurations.length, 3);
    expect(model.columnConfigurations[0].weight, 2);
    expect(
        ((model.columnConfigurations[0].header as TextButton).child as Text)
            .data,
        'Column 1');
    expect((model.columnConfigurations[1].header as Icon).icon,
        Icons.access_alarm);
    expect((model.columnConfigurations[2].header as Text).data, 'Column 3');
  });

  test(
      'Creating a simple table model with auto created headers only'
      '--> Weight should be distributed equally between the columns', () {
    var model = CollapsibleGridController<num>(columnConfigurations: [
      'Column 1',
      'Column 2',
      'Column 3',
    ], rowConfigurations: []);

    var commonWeight = model.columnConfigurations[0].weight;

    expect(model.columnConfigurations.length, 3);
    expect(model.columnConfigurations[1].weight, commonWeight);
    expect(model.columnConfigurations[2].weight, commonWeight);
  });

  test(
      'Creating a simple table model with a single row'
      '--> Row count should be 1', () {
    var model = CollapsibleGridController<num>(
        columnConfigurations: defaultTestColumns,
        rowConfigurations: [
          RowConfiguration<num>(cells: [1, 2, 3])
        ]);

    expect(model.rowConfigurations.length, 1);
  });
}
