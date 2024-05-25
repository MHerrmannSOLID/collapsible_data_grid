import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/static_table_row.dart';
import 'package:collapsible_data_grid/src/table_header.dart';
import 'package:flutter/material.dart';
import 'types/expandable_row.dart';
import 'types/row_configuration.dart';

class CollapsibleDataGrid extends StatefulWidget {
  final CollapsibleGridController controller;
  final headerHeight = 50.0;
  final Color _bodyBackground;
  final Color _headerBackground;
  final List columnConfigurations;
  final List<RowConfiguration> rowConfigurations;

  const CollapsibleDataGrid({
    super.key,
    required this.controller,
    required this.columnConfigurations,
    required this.rowConfigurations,
    Color? bodyBackground,
    Color? headerBackground,
  })  : _bodyBackground = bodyBackground ?? Colors.white,
        _headerBackground = headerBackground ?? Colors.white;

  @override
  State<StatefulWidget> createState() => CollapsibleDataGridState();
}

class CollapsibleDataGridState extends State<CollapsibleDataGrid> {
  @override
  void initState() {
    super.initState();
    widget.controller
        .initialize(widget.columnConfigurations, widget.rowConfigurations);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableHeader(
                columns: widget.controller.columnConfigurations,
                headerBackground: widget._headerBackground),
            Container(
              height: constraints.maxHeight - widget.headerHeight,
              color: widget._bodyBackground,
              child: ListView(
                children: widget.controller.rowConfigurations
                    .map((rowData) => _createTileFrom(rowData))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _createTileFrom(RowConfiguration data) => (data.isExpandable)
      ? ExpandableTableRow(
          columnConfigurations: widget.controller.columnConfigurations,
          data: data as ExpandableRow)
      : StaticTableRow(
          columnConfigurations: widget.controller.columnConfigurations,
          rowData: data);
}
