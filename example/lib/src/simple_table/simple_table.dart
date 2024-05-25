import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid_example/src/demo_app_bar.dart';
import 'package:flutter/material.dart';

class SimpleTable extends StatefulWidget {
  const SimpleTable({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SimpleTable> createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  final model = CollapsibleGridController(
    cellStyleBuilder: (colIdx, rowIdx, toStyle) => toStyle
      ..borderConfiguration = CellBorderConfiguration(
          bottomBorder: BorderSide(style: BorderStyle.solid))
      ..backgroundColor = Colors.red.shade100,
  );

  _SimpleTableState() {}

  @override
  Widget build(BuildContext context) {
    var columnConfigurations = [
      'Column 1',
      'Column 2',
      'Column 3',
    ];
    var rowConfigurations = [
      RowConfiguration<String>(
          cells: ['Row 1, Column 1', 'Row 1, Column 2', 'Row 1, Column 3']),
      RowConfiguration<String>(
          cells: ['Row 2, Column 1', 'Row 2, Column 2', 'Row 2, Column 3']),
      RowConfiguration<String>(
          cells: ['Row 3, Column 1', 'Row 3, Column 2', 'Row 3, Column 3']),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: DemoAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.90,
                height: constraints.maxHeight * 0.90,
                child: CollapsibleDataGrid(
                  columnConfigurations: columnConfigurations,
                  rowConfigurations: rowConfigurations,
                  headerBackground: Colors.blueGrey,
                  bodyBackground: Colors.blueGrey.shade100,
                  controller: model,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
