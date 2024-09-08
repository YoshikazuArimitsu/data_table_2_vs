import 'dart:math' as math;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataTable2Vs extends StatefulWidget {
  const DataTable2Vs(
      {
        super.key,

        // DataTable
        this.sortColumnIndex,
        this.sortAscending = true,
        this.onSelectAll,
        this.decoration,
        this.dataRowColor,
        this.dataTextStyle,
        this.headingRowColor,
        this.headingRowHeight,
        this.headingTextStyle,
        this.horizontalMargin,
        this.columnSpacing,
        this.showCheckboxColumn = true,
        this.showBottomBorder = false,
        this.dividerThickness,
        this.checkboxHorizontalMargin,
        this.border,
        required this.columns,
        required this.rows,

        // DataTable2
        this.dataRowHeight,
        this.fixedColumnsColor,
        this.fixedCornerColor,
        this.headingCheckboxTheme,
        this.datarowCheckboxTheme,
        this.checkboxAlignment = Alignment.center,
        this.bottomMargin,
        this.showHeadingCheckBox = true,
        this.minWidth,
        this.scrollController,
        this.horizontalScrollController,
        this.isVerticalScrollBarVisible,
        this.isHorizontalScrollBarVisible,
        this.empty,
        this.smRatio = 0.67,
        this.fixedTopRows = 1,
        this.fixedLeftColumns = 0,
        this.lmRatio = 1.2,
        this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
        this.sortArrowIcon = Icons.arrow_upward,
        this.sortArrowBuilder,
        this.headingRowDecoration,

        // DataTable2Vs
        this.pageSize = 100,
      }
  );

  // DataTable
  final int? sortColumnIndex;
  final bool sortAscending;
  final ValueSetter<bool?>? onSelectAll;
  final Decoration? decoration;
  final MaterialStateProperty<Color?>? dataRowColor;
  final TextStyle? dataTextStyle;
  final MaterialStateProperty<Color?>? headingRowColor;
  final double? headingRowHeight;
  final TextStyle? headingTextStyle;
  final double? horizontalMargin;
  final double? columnSpacing;
  final bool showCheckboxColumn;
  final double? dividerThickness;
  final bool showBottomBorder;
  final double? checkboxHorizontalMargin;
  final TableBorder? border;
  final List<DataColumn2> columns;
  final List<DataRow2> rows;

  // DataTable2
  final double? dataRowHeight;
  final ScrollController? scrollController;
  final ScrollController? horizontalScrollController;
  final bool? isVerticalScrollBarVisible;
  final bool? isHorizontalScrollBarVisible;
  final Widget? empty;
  final double smRatio;
  final double lmRatio;
  final int fixedTopRows;
  final int fixedLeftColumns;
  final Color? fixedColumnsColor;
  final Color? fixedCornerColor;
  final CheckboxThemeData? headingCheckboxTheme;
  final double? minWidth;
  final Alignment checkboxAlignment;
  final bool showHeadingCheckBox;
  final CheckboxThemeData? datarowCheckboxTheme;
  final double? bottomMargin;
  final Duration sortArrowAnimationDuration;
  final IconData sortArrowIcon;
  final Widget? Function(bool ascending, bool sorted)? sortArrowBuilder;
  final BoxDecoration? headingRowDecoration;

  // DataTable2Vs
  final int pageSize;

  @override
  State<DataTable2Vs> createState() => _DataTable2VsState();
}

class _DataTable2VsState extends State<DataTable2Vs> {
  int startRow = 0;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    // ScrollControllerが無ければ作ってリスナー追加
    scrollController = widget.scrollController ?? ScrollController(
      onAttach: onAttach
    );
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    // ScrollController作っていれば解放
    if(widget.scrollController == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  void onAttach(ScrollPosition position) {

  }

  void onScroll() {
    if (widget.rows.length <= widget.pageSize) {
      // 仮想ページング不要
      return;
    }

    final prevStartRow = startRow;
    final offset = scrollController.offset;
    final totalExtent = (scrollController.position.maxScrollExtent - scrollController.position.minScrollExtent)
      + scrollController.position.viewportDimension;
    final extentByRow = totalExtent / widget.pageSize;

    debugPrint('offset: $offset, extent:${scrollController.position.minScrollExtent} ~ ${scrollController.position.maxScrollExtent}');
    debugPrint('extentByRow: $extentByRow, dimension:${scrollController.position.viewportDimension}');

    // ↑
    if(startRow > 0) {
      if(offset <= scrollController.position.minScrollExtent) {
        // 先頭行を pageSize / 2 行スライド
        final newStartRow = math.max(startRow - widget.pageSize ~/ 2, 0);
        setState(() {
          startRow = newStartRow;
        });

        // スライドした分+1行分スクロール位置をずらす
        scrollController.jumpTo(scrollController.offset + (prevStartRow - newStartRow) * extentByRow
          - extentByRow);
      }
    }

    // ↓
    if(startRow < widget.rows.length - widget.pageSize) {
      if(offset >= scrollController.position.maxScrollExtent) {
        // 先頭行を pageSize / 2 行スライド
        final newStartRow = math.min(startRow + widget.pageSize ~/ 2, widget.rows.length - widget.pageSize);
        setState(() {
          startRow = newStartRow;
        });

        // スライド分+1行分スクロール位置をずらす
        scrollController.jumpTo(scrollController.offset + (prevStartRow - newStartRow) * extentByRow
          + extentByRow);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int endRow = math.min(startRow + widget.pageSize, widget.rows.length);

    return DataTable2(
      sortColumnIndex : widget.sortColumnIndex,
      sortAscending : widget.sortAscending,
      onSelectAll : widget.onSelectAll,
      decoration : widget.decoration,
      dataRowColor : widget.dataRowColor,
      dataTextStyle : widget.dataTextStyle,
      headingRowColor : widget.headingRowColor,
      headingRowHeight : widget.headingRowHeight,
      headingTextStyle : widget.headingTextStyle,
      horizontalMargin : widget.horizontalMargin,
      columnSpacing : widget.columnSpacing,
      showCheckboxColumn : widget.showCheckboxColumn,
      dividerThickness : widget.dividerThickness,
      showBottomBorder : widget.showBottomBorder,
      checkboxHorizontalMargin : widget.checkboxHorizontalMargin,
      border : widget.border,
      columns : widget.columns,
      dataRowHeight : widget.dataRowHeight,
      horizontalScrollController : widget.horizontalScrollController,
      isVerticalScrollBarVisible : widget.isVerticalScrollBarVisible,
      isHorizontalScrollBarVisible : widget.isHorizontalScrollBarVisible,
      empty : widget.empty,
      smRatio : widget.smRatio,
      lmRatio : widget.lmRatio,
      fixedTopRows : widget.fixedTopRows,
      fixedLeftColumns : widget.fixedLeftColumns,
      fixedColumnsColor : widget.fixedColumnsColor,
      fixedCornerColor : widget.fixedCornerColor,
      headingCheckboxTheme : widget.headingCheckboxTheme,
      minWidth : widget.minWidth,
      checkboxAlignment : widget.checkboxAlignment,
      showHeadingCheckBox : widget.showHeadingCheckBox,
      datarowCheckboxTheme : widget.datarowCheckboxTheme,
      bottomMargin : widget.bottomMargin,
      sortArrowAnimationDuration : widget.sortArrowAnimationDuration,
      sortArrowIcon : widget.sortArrowIcon,
      sortArrowBuilder : widget.sortArrowBuilder,
      headingRowDecoration : widget.headingRowDecoration,

      rows : widget.rows.sublist(startRow, endRow),
      scrollController : scrollController,
    );
  }
}