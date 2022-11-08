import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ff_header_labels.dart';
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
      builder: (_, bool headerIsExpanded, Widget headerLabels){

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
          child: headerLabels,
        );

      },
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
                  authorImage: flyerModel.authorImage,
                  bzModel: bzModel,
                  headerIsExpanded: false, //_headerIsExpanded,
                  flyerShowsAuthor: flyerModel.showsAuthor,
                  showHeaderLabels: true,
                ),

            ],
          ),
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
