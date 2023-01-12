import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_icons_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verses_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class Obelisk extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Obelisk({
    @required this.isExpanded,
    @required this.onTriggerExpansion,
    @required this.onRowTap,
    @required this.progressBarModel,
    @required this.navModels,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final Function onTriggerExpansion;
  final ValueChanged<int> onRowTap;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final List<NavModel> navModels;
  // --------------------
  static const double circleWidth = 40;
  static const boxWidth = circleWidth + (2 * Ratioz.appBarPadding);
  // --------------------
  // static double getBoxMaxHeight({
  //   @required bool isBig,
  //   @required int numberOfButtons,
  // }){
    // const double _circleWidth = Obelisk.circleWidth;
    // final double _height = isBig ?
    // ((numberOfButtons * _circleWidth) + ((numberOfButtons+1) * Ratioz.appBarPadding))
    //     :
    // boxWidth;

    // return _height + 30;
  // }
  // --------------------

  static double getContentsHeight({
    @required BuildContext context,
    @required List<NavModel> navModels,
  }){

    double _result = 0;
    // int _numberOfCircles = 0;

    if (Mapper.checkCanLoopList(navModels) == true){

      for (final NavModel navModel in navModels){

        if (navModel?.canShow == true){
          _result = _result + Obelisk.circleWidth;
          // _numberOfCircles++;
        }
        else if (navModel?.canShow == false){
          _result = _result + 0;
        }
        else {
          _result = _result + SeparatorLine.standardThickness + 10;
        }

      }

    }

    // if (_numberOfCircles > 0){
    //   _result = Scale.screenWidth(context) * 0.82;
    // }

    return _result;
  }

  static dynamic stuffAlignment({
    @required bool isCross,
  }){

    const bool isStart = true;

    /// CrossAxisAlignment
    if (isCross == true){
      return isStart == true ? CrossAxisAlignment.center : CrossAxisAlignment.end;
    }

    /// MainAxisAlignment
    else {
      return isStart == true ?  MainAxisAlignment.center : MainAxisAlignment.end;
    }

  }
  // --------------------

  static double extraHeightToAchieveScrollability({
    @required BuildContext context,
    @required List<NavModel> navModels,
}){

    /// so the inner box that has a height specified by [getContentsHeight] can be less
    /// than the max height of the pyramid box which is [getMaxHeight]
    /// so

    final double _contentsHeight = getContentsHeight(
      context: context,
      navModels: navModels,
    );

    final double _maxHeight = getMaxHeight(context);

    /// contents height is less than max height : contents are SHORTER
    if (_contentsHeight < _maxHeight){
      return (_maxHeight - _contentsHeight) + 20;
    }

    /// contets height is more than max height : contents are LONGER
    else {
      return 0;
    }

  }
  // --------------------
  static double getMaxHeight(BuildContext context){
    return Scale.screenWidth(context) * 0.82;
  }
  // --------------------
  static double gotContentsScrollableHeight({
    @required BuildContext context,
    @required List<NavModel> navModels,
}){

    return
          getContentsHeight(
              context: context,
              navModels: navModels
          )
          +
          extraHeightToAchieveScrollability(
            context: context,
            navModels: navModels,
          );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Positioned(
      key: const ValueKey<String>('Obelisk'),
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        child: SizedBox(
          height: getMaxHeight(context),
          // color: Colorz.bloodTest,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: stuffAlignment(isCross: true),
              children: <Widget>[

                /// ICONS
                if (TextDir.checkAppIsLeftToRight(context) == true)
                  ObeliskIconsBuilder(
                    isExpanded: isExpanded,
                    navModels: navModels,
                    progressBarModel: progressBarModel,
                    onRowTap: onRowTap,
                  ),

                /// TEXTS
                ObeliskVersesBuilder(
                  isExpanded: isExpanded,
                  navModels: navModels,
                  progressBarModel: progressBarModel,
                  onRowTap: onRowTap,
                ),

                /// ICONS
                if (TextDir.checkAppIsLeftToRight(context) == false)
                  ObeliskIconsBuilder(
                    isExpanded: isExpanded,
                    navModels: navModels,
                    progressBarModel: progressBarModel,
                    onRowTap: onRowTap,
                  ),

              ],
            ),
          ),
        ),
        builder: (_, bool expanded, Widget child){

          final bool _ignore = expanded == null || expanded == true ? false : true;

          return IgnorePointer(
            ignoring: _ignore,
            child: child,
          );

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
