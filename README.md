![main_build](https://github.com/MHerrmannSOLID/collapsible_data_grid/actions/workflows/dart.yml/badge.svg) [![codecov](https://codecov.io/github/MHerrmannSOLID/collapsible_data_grid/graph/badge.svg?token=C0Q6V8F9FO)](https://codecov.io/github/MHerrmannSOLID/collapsible_data_grid) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Yet Another Data Grid  

Yet another data grid ... but why for god's sake? Basically because we needed a data grid for our project that can be grouped by column content, such as the same date, same amount/value, same operator, same project, etc., and then collapse all affected rows into a single expandable row. 
Since we were not able to find something suitable, "Yet Another Data Grid" was born. :upside_down_face:  

# What is collapsible_data_grid 

The collapsible_data_grid was designed to be easy to use while offering a wide range of possibilities for those who want to explore its full potential. However, as aforementioned, the main intention was to offer expandable rows and accompanied with that mechanism, an automatic and efficient method to determine such row candidates and automatically _collapse_ them to a single row.

 

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Styling the Grid
Since flutter provides already a [DataTable] in within the default installation, we try to allign as close as possible with the the style of [DataTableThemeData]. In the specific case where there is no dedicated [CollapsibleDataGridThemeData] oar any direct stying availbale, this lbrary will look out for [DataTableThemeData] and copy conguent parameters from there. Given the case that there is also no [DataTableThemeData] it'll create the defaults absed on the general [ThemeData] in the same way as [DataTableThemeData]. This way the [CollapsibleDataGrid] will always allign with the general appearance of the UI.
The priorities for styling are:

1. Directstyling via the constructor
2. Styling though the [CollapsibleDataGridThemeData]
3. Indirect styling though [DataTableThemeData]
3. Indirect styling though [ThemeData]

