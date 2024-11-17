import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid/src/services/theme_resolver.dart';
import 'package:collapsible_data_grid/src/widgets/expandable_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/static_table_row.dart';
import 'package:collapsible_data_grid/src/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollapsibleDataGrid extends StatelessWidget {
  final CollapsibleGridController controller;
  final headerHeight = 56.0;
  final List columnConfigurations;
  final List<RowConfiguration> rowConfigurations;
  final int collapseByColumn;

  //styling
  final TextStyle? headerTextStyle;
  final TextStyle? dataCellTextStyle;
  final bool showExpansionIcon;
  final bool showExpansionInsets;

  const CollapsibleDataGrid({
    super.key,
    required this.controller,
    required this.columnConfigurations,
    required this.rowConfigurations,
    this.collapseByColumn = -1,
    this.headerTextStyle,
    this.dataCellTextStyle,
    this.showExpansionIcon = true,
    this.showExpansionInsets = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = ThemeResolver.resolve(this, Theme.of(context));
    controller.initialize(columnConfigurations, rowConfigurations);
    if (collapseByColumn > -1) {
      controller.collapseColumn(columnIdx: collapseByColumn);
    }
    return Provider(
      create: (c) => theme,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableHeader(
                  columns: controller.columnConfigurations,
                ),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    return Expanded(
                      child: ListView(
                        children: controller.rowConfigurations
                            .map((rowData) => _createRowFrom(rowData))
                            .toList(),
                      ),
                    );
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _createRowFrom(RowConfiguration data) => (data.isExpandable)
      ? ExpandableTableRow(
          columnConfigurations: controller.columnConfigurations,
          data: data as ExpandableRow)
      : StaticTableRow(
          columnConfigurations: controller.columnConfigurations, rowData: data);
}
