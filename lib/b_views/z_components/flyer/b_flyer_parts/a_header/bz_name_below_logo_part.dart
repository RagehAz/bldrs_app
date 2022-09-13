import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class LinesBelowLogoPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LinesBelowLogoPart({
    @required this.flyerBoxWidth,
    @required this.firstLine,
    @required this.secondLine,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse firstLine;
  final Verse secondLine;
  final ValueNotifier<bool> headerIsExpanded; /// p
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : TEMP
    return ValueListenableBuilder<bool>(
        valueListenable: headerIsExpanded,
        child: Container(
          color: Colorz.black80,
          child: MaxHeaderHeadline(
            flyerBoxWidth: flyerBoxWidth,
            bzPageIsOn: true,
            firstLine: firstLine,
            secondLine: secondLine,
          ),
        ),
        builder: (_, bool _headerIsExpanded, Widget child){

          if (_headerIsExpanded == true){
            return child;
          }

          else {
            return const SizedBox();
          }

        }
    );

  }
/// --------------------------------------------------------------------------
}
