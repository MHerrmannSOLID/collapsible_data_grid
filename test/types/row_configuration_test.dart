import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../test_helper.dart';

void main() {
  testWidgets(
      'Creating a row configuration with 2 cells'
      '--> There will be 2wo cells with the accoring chldWidgetss',
      (tester) async {
    var model = RowConfiguration(cells: [
      GridCellData(child: const Text('Cell 1'), groupKey: 'Cell 1'),
      GridCellData(child: const Text('Cell 2'), groupKey: 'Cell 1'),
    ]);

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());

    expect(model.getCells().length, 2);
    expect(find.text('Cell 1'), findsOneWidget);
    expect(find.text('Cell 2'), findsOneWidget);
  });

  testWidgets(
      'Creating a row configuration by strings only'
      '--> The strings will be wrapped into cell data', (tester) async {
    var model = RowConfiguration(cells: [
      'Cell 1',
      'Cell 2',
    ]);

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());
    expect(model.getCells().length, 2);
    expect(find.text('Cell 1'), findsOneWidget);
    expect(find.text('Cell 2'), findsOneWidget);
  });

  testWidgets(
      'Creating a row configuration from widgets'
      '--> The widgets will be wrapped into cell data and displayed',
      (tester) async {
    var model = RowConfiguration(cells: [
      const Collapsible<num>(groupKey: 1, child: Icon(Icons.ac_unit)),
      const Collapsible<num>(groupKey: 2, child: Icon(Icons.access_alarm)),
    ]);

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());

    expect(model.getCells().length, 2);
    expect(find.byIcon(Icons.ac_unit), findsOneWidget);
    expect(find.byIcon(Icons.access_alarm), findsOneWidget);
  });

  testWidgets(
      'Creating a row configuration containing numbers and requesting german formatting'
      '--> The numbers will be wrapped into cell data and and correctly formated',
      (tester) async {
    var model = RowConfiguration(cells: [
      2.346,
      12,
    ], numberFormat: NumberFormat('#.##', 'de_DE'));

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());

    expect(model.getCells().length, 2);
    expect(find.text('2,35'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
  });

  testWidgets(
      'Creating a row configuration containing numbers and requesting us currencie formatting'
      '--> The numbers will be wrapped into cell data and and correctly formated',
      (tester) async {
    var model = RowConfiguration(cells: [
      2.346,
      12,
    ], numberFormat: NumberFormat.currency(locale: 'en_US', symbol: '\$'));

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());

    expect(model.getCells().length, 2);
    expect(find.text('\$2.35'), findsOneWidget);
    expect(find.text('\$12.00'), findsOneWidget);
  });

  testWidgets(
      'Creating directly from custom widgets'
      '--> The row confcuration will contain the custom widgets',
      (tester) async {
    var model = RowConfiguration(cells: [
      CustomTestWidget(text: 'Cell 1'),
      CustomTestWidget(text: 'Cell 2'),
    ]);

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());
    expect(model.getCells().length, 2);
    expect(find.byKey(Key('Cell 1')), findsOneWidget);
    expect(find.byKey(Key('Cell 2')), findsOneWidget);
  });

  testWidgets(
      'Having a row configuration with non compareable widgets'
      '--> Widgets gets wrapped in Collapsibles and get a dummy group key of 0',
      (tester) async {
    var model = RowConfiguration(cells: [
      CustomTestWidget(text: 'Cell 1'),
      CustomTestWidget(text: 'Cell 2'),
    ]);

    await tester.pumpWidget(
        Row(children: model.getCells().map((cell) => cell.buildCell()).toList())
            .wrapDirectional());

    var collapsibleWrapperCell1 = tester
        .element(find.byKey(Key('Cell 1')))
        .findAncestorWidgetOfExactType<Collapsible<num>>();
    var collapsibleWrapperCell2 = tester
        .element(find.byKey(Key('Cell 2')))
        .findAncestorWidgetOfExactType<Collapsible<num>>();

    expect(collapsibleWrapperCell2!.child, isA<CustomTestWidget>());
    expect(collapsibleWrapperCell2!.groupKey, 0);
    expect(collapsibleWrapperCell1!.child, isA<CustomTestWidget>());
    expect(collapsibleWrapperCell1!.groupKey, 0);
  });
}

class CustomTestWidget extends StatelessWidget {
  final String text;

  CustomTestWidget({required this.text}) : super(key: Key(text));

  @override
  Widget build(BuildContext context) => Placeholder();
}
