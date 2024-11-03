import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid_example/src/demo_app_bar.dart';
import 'package:collapsible_data_grid_example/src/data/projects_data_factory.dart';
import 'package:collapsible_data_grid_example/src/material_style_table/table_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HeaderBuilderDemo extends StatefulWidget {
  const HeaderBuilderDemo({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HeaderBuilderDemo> createState() => _HeaderBuilderDemoState();
}

class _HeaderBuilderDemoState extends State<HeaderBuilderDemo>
    with SingleTickerProviderStateMixin {
  var model;
  final tableController =
      CollapsibleGridController(collapseHeaderBuilder: _headerBilder);

  @override
  void initState() {
    model = TableModel();
    _getTableData();
    super.initState();
  }

  Future<void> _getTableData() async {
    var tasksModel = await ProjectsDataFactory.createFromAsset(
        assetPath: 'assets/project_sample_data.txt');
    model = TableModel.formProjectsData(tasksModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: DemoAppBar(),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              child: const Text("fold"),
              onPressed: () => tableController.collapseColumn(columnIdx: 4),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.90,
                    height: constraints.maxHeight * 0.90,
                    child: CollapsibleDataGrid(
                      columnConfigurations: model.columns,
                      rowConfigurations: model.rows,
                      controller: tableController,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  static List<GridCellData<Comparable>> _headerBilder(
      List<RowConfiguration> rows, ExpandableController controller) {
    var firstCell = rows.first.getCells().first;
    return <GridCellData>[
      GridCellData(
          colSpan: 8,
          alignmentGeometry: Alignment.centerLeft,
          borderConfiguration: firstCell.borderConfiguration,
          child: _createRowWidget(controller, rows),
          groupKey: 1)
    ];
  }

  static SizedBox _createRowWidget(
      ExpandableController controller, List<RowConfiguration> rows) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        ExpansionIcon(
          contoller: controller,
        ),
        Text(
          " Having  ${rows.length} entries at the ${_getDateFrom(rows.first)} ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.left,
        ),
      ]),
    );
  }

  static String _getDateFrom(RowConfiguration row) {
    var dateFromatter = DateFormat('dd.MM.yyyy');
    var date = row.getCells()[4].groupKey as DateTime;
    return dateFromatter.format(date);
  }
}
