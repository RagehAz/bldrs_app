import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_icons_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verses_builder.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class Obelisk extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Obelisk({
    required this.onRowTap,
    required this.progressBarModel,
    required this.navModels,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<int> onRowTap;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final List<NavModel?> navModels;
  // --------------------
  static const double circleWidth = 40;
  static const boxWidth = circleWidth + (2 * Ratioz.appBarPadding);
  // --------------------
  // static double getBoxMaxHeight({
  //   required bool isBig,
  //   required int numberOfButtons,
  // }){
    // const double _circleWidth = Obelisk.circleWidth;
    // final double _height = isBig ?
    // ((numberOfButtons * _circleWidth) + ((numberOfButtons+1) * Ratioz.appBarPadding))
    //     :
    // boxWidth;

    // return _height + 30;
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getContentsHeight({
    required BuildContext context,
    required List<NavModel?> navModels,
  }){

    double _result = 0;
    // int _numberOfCircles = 0;

    if (Mapper.checkCanLoopList(navModels) == true){

      for (final NavModel? navModel in navModels){

        if (Mapper.boolIsTrue(navModel?.canShow) == true){
          _result = _result + Obelisk.circleWidth;
          // _numberOfCircles++;
        }
        else if (Mapper.boolIsTrue(navModel?.canShow) == false){
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic stuffAlignment({
    required bool isCross,
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
  /// TESTED : WORKS PERFECT
  static double extraHeightToAchieveScrollability({
    required BuildContext context,
    required List<NavModel?> navModels,
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

      /// contents height is more than max height : contents are LONGER
      else {
        return 0;
      }

    }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getMaxHeight(BuildContext context){
    return Scale.screenWidth(context) * 0.82;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double gotContentsScrollableHeight({
    required BuildContext context,
    required List<NavModel?> navModels,
  }){

    final bool _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (_isLandScape == true){
      return getContentsHeight(
                 context: context,
                 navModels: navModels
             ) + 100;
    }

    else {
      return getContentsHeight(
                 context: context,
                 navModels: navModels
             )
             +
             extraHeightToAchieveScrollability(
               context: context,
               navModels: navModels,
             ) + 40;
    }
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (_isLandScape == true){
      return Positioned(
        key: const ValueKey<String>('Obelisk'),
        right: Ratioz.appBarMargin,
        bottom: Ratioz.appBarMargin,
        child: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
          builder: (_, bool? expanded, Widget? child) {

            final bool _ignore = expanded == null || expanded == true ? false : true;

            return IgnorePointer(
              ignoring: _ignore,
              child: child,
            );
          },
          child: SizedBox(
            height: 300,
            child: MaxBounceNavigator(
              onNavigate: () => UiProvider.proSetPyramidsAreExpanded(
                setTo: false,
                notify: true,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    /// TEXTS
                    ObeliskVersesBuilder(
                      navModels: navModels,
                      progressBarModel: progressBarModel,
                      onRowTap: onRowTap,
                    ),

                    /// ICONS
                    ObeliskIconsBuilder(
                      navModels: navModels,
                      progressBarModel: progressBarModel,
                      onRowTap: onRowTap,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    else {
      return Positioned(
        key: const ValueKey<String>('Obelisk'),
        left: Ratioz.appBarMargin,
        bottom: Ratioz.appBarMargin,
        child: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
          builder: (_, bool? expanded, Widget? child) {

            final bool _ignore = expanded == null || expanded == true ? false : true;

            return IgnorePointer(
              ignoring: _ignore,
              child: child,
            );
          },
          child: SizedBox(
            height: getMaxHeight(context),
            // color: Colorz.bloodTest,
            child: MaxBounceNavigator(
              onNavigate: () => UiProvider.proSetPyramidsAreExpanded(
                setTo: false,
                notify: true,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: stuffAlignment(isCross: true),
                  children: <Widget>[

                    /// ICONS
                    if (UiProvider.checkAppIsLeftToRight() == true)
                      ObeliskIconsBuilder(
                        navModels: navModels,
                        progressBarModel: progressBarModel,
                        onRowTap: onRowTap,
                      ),

                    /// TEXTS
                    ObeliskVersesBuilder(
                      navModels: navModels,
                      progressBarModel: progressBarModel,
                      onRowTap: onRowTap,
                    ),

                    /// ICONS
                    if (UiProvider.checkAppIsLeftToRight() == false)
                      ObeliskIconsBuilder(
                        navModels: navModels,
                        progressBarModel: progressBarModel,
                        onRowTap: onRowTap,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  // -----------------------------------------------------------------------------
}
