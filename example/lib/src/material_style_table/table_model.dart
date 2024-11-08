import 'package:collapsible_data_grid/collapsible_data_grid.dart';
import 'package:collapsible_data_grid_example/src/data/projects_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TableModel {
  final TextStyle headerFont = GoogleFonts.rubik(
      textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20));
  final TextStyle bodyFont = GoogleFonts.rubik(
      textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16));
  late final List<ColumnConfiguration> columns;
  final outputFormat = DateFormat('dd/MM/yyyy');

  late final List<RowConfiguration> rows;
  final _borderConfiguration = CellBorderConfiguration(
      bottomBorder: BorderSide(color: Colors.grey.shade300));

  TableModel() {
    columns = [];
    rows = [];
  }

  TableModel.formProjectsData(ProjectsData data) {
    columns = data.columnHeaders
        .map((headerText) => ColumnConfiguration(
            header: SizedBox(
              child: Text(
                headerText,
                style: headerFont,
              ),
            ),
            borderConfiguration: _borderConfiguration))
        .toList();

    rows = data.data
        .map(
          (e) => RowConfiguration(cells: [
            _standardCell(Text(e.workOrder, style: bodyFont), e.workOrder),
            _standardCell(Text(e.district, style: bodyFont), e.district),
            _standardCell(Text(e.leadTech, style: bodyFont), e.leadTech),
            _standardCell(Icon(e.service, size: 30), 1 as num),
            _standardCell(Text(outputFormat.format(e.reqDate), style: bodyFont),
                e.reqDate),
            _standardCell(
                Text(outputFormat.format(e.workDate), style: bodyFont),
                e.workDate),
            _standardCell(
                Text(e.techs.toString(), style: bodyFont), e.techs.toString()),
            _standardCell(Text(e.payment, style: bodyFont), e.payment),
          ]),
        )
        .toList();
  }

  GridCellData _standardCell<TGroupKey extends Comparable<TGroupKey>>(
          Widget toDisplay, TGroupKey groupKey) =>
      GridCellData<TGroupKey>(
          groupKey: groupKey,
          child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20), child: toDisplay),
          borderConfiguration: _borderConfiguration,
          alignmentGeometry: Alignment.centerLeft);
}
