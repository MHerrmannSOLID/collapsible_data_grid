import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({required this.rows, required this.controller, super.key});

  final List<RowConfiguration> rows;
  final ExpandableController controller;

  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        ExpansionIcon(
          contoller: controller,
        ),
        Text(
          " Having  ${rows.length} entries at the ${_getDateFrom(rows.first)} ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.left,
        ),
      ]),
    );
  }

  static String _getDateFrom(RowConfiguration row) {
    var dateFromatter = DateFormat('dd.MM.yyyy');
    var date = (row.getCells()[4] as GridCellData)?.groupKey as DateTime;
    return dateFromatter.format(date);
  }
}
