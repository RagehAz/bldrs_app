import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_labels.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderLabelsTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabelsTree({
    @required this.headerLabelsWidthTween,
    @required this.logoMinWidth,
    @required this.logoSizeRatioTween,
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.tinyMode,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Animation<double> headerLabelsWidthTween;
  final double logoMinWidth;
  final Animation<double> logoSizeRatioTween;
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final bool tinyMode;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<bool>(
      valueListenable: headerIsExpanded,
      child: Center(
        child: SizedBox(
          width: headerLabelsWidthTween.value,
          height: logoMinWidth * logoSizeRatioTween.value,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[

              if (tinyMode == false)
                HeaderLabels(
                  flyerBoxWidth: flyerBoxWidth  * logoSizeRatioTween.value,
                  authorID: flyerModel.authorID,
                  bzModel: bzModel,
                  headerIsExpanded: false, //_headerIsExpanded,
                  flyerShowsAuthor: flyerModel.showsAuthor,
                ),

            ],
          ),
        ),
      ),
      builder: (_, bool headerIsExpanded, Widget child){

        final double _opacity =
        headerIsExpanded == true ? 0
            :
        tinyMode == true ? 0
            :
        1;

        return AnimatedOpacity(
          key: const ValueKey<String>('Header_labels_Animated_opacity'),
          opacity: _opacity,
          duration: Ratioz.durationFading200,
          child: child,
        );

      },
    );

  }
/// --------------------------------------------------------------------------
}
