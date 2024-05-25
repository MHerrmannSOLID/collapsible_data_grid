import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid_example/src/demo_app_bar.dart';
import 'package:collapsible_data_grid_example/src/data/projects_data_factory.dart';
import 'package:collapsible_data_grid_example/src/material_style_table/table_model.dart';
import 'package:flutter/material.dart';

class MaterialStyleTable extends StatefulWidget {
  const MaterialStyleTable({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MaterialStyleTable> createState() => _MaterialStyleTableState();
}

class _MaterialStyleTableState extends State<MaterialStyleTable>
    with SingleTickerProviderStateMixin {
  var model = TableModel();

  @override
  void initState() {
    _getTableData();
    super.initState();
  }

  Future<void> _getTableData() async {
    var tasksModel = await ProjectsDataFactory.createFromAsset(
        assetPath: 'assets/project_sample_data.txt');
    setState(() {
      model = TableModel.formProjectsData(tasksModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: DemoAppBar(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                child: SizedBox(
                  width: constraints.maxWidth * 0.90,
                  height: constraints.maxHeight * 0.90,
                  child: CollapsibleDataGrid(
                      columnConfigurations: model.columns,
                      rowConfigurations: model.rows,
                      controller: CollapsibleGridController<String>()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
