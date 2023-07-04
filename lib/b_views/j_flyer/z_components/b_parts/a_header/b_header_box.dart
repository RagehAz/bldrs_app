import 'package:flutter/material.dart';

class HeaderBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderBox({
    required this.flyerBoxWidth,
    required this.headerHeightTween,
    required this.headerColor,
    required this.headerBorders,
    required this.child,
    this.headerIsExpanded,
    this.onHeaderTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onHeaderTap;
  final double flyerBoxWidth;
  /// either double of Animation<double>
  final dynamic headerHeightTween;
  final Color? headerColor;
  final BorderRadius? headerBorders;
  final Widget child;
  final ValueNotifier<bool>? headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget tree = Container(
      width: flyerBoxWidth,
      height: headerHeightTween is Animation<double> ? headerHeightTween.value : headerHeightTween,
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: headerBorders,
      ),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: child,
      ),
    );

    if (headerIsExpanded == null){
      return GestureDetector(
        onTap: onHeaderTap == null ? null : () => onHeaderTap!.call(),
        child: tree,
      );
    }

    else {

      return ValueListenableBuilder(
          valueListenable: headerIsExpanded!,
          builder: (_, bool isExpanded, Widget? widgetTree){

            return GestureDetector(
              onTap: isExpanded == true ? null : () => onHeaderTap?.call(),
              child: widgetTree,
            );

          },
        child: tree,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
