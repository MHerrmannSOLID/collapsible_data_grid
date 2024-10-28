import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({required this.rows, super.key});

  final List<RowConfiguration> rows;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        ExpansionIcon(
          contoller: ExpandableController(),
          vsync: this,
        ),
        Text(
          "--> Having  ${widget.rows.length} entries at the ${_getDateFrom(widget.rows.first)} ",
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
