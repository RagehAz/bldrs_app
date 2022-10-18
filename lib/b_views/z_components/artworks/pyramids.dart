import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/a_dashboard_home_screen.dart';
import 'package:flutter/material.dart';

enum PyramidType{
  yellow,
  crystalYellow,

  white,
  crystalWhite,

  crystalBlue,
  glass,

  non,
}

class Pyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Pyramids({
    @required this.pyramidType,
    this.loading,
    this.onPyramidTap,
    this.color,
    this.putInCorner = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function onPyramidTap;
  final Color color;
  final bool putInCorner;
  /// --------------------------------------------------------------------------
  static double verticalPositionFix = -0.2;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final Widget pyramidsWidget = _PyramidsWidgetTree(
      pyramidType: pyramidType,
      loading: loading,
      onPyramidTap: onPyramidTap,
      color: color,
      putInCorner: putInCorner,
    );

    if (putInCorner == true){
      return Positioned(
        bottom: Pyramids.verticalPositionFix,
        right: 17 * 0.7,
        child: pyramidsWidget,
      );
    }

    else {
      return pyramidsWidget;
    }

    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _PyramidsWidgetTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PyramidsWidgetTree({
    @required this.pyramidType,
    @required this.loading,
    @required this.onPyramidTap,
    @required this.color,
    @required this.putInCorner,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function onPyramidTap;
  final Color color;
  final bool putInCorner;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onPyramidTap,
        onDoubleTap: () => onPyramidAdminDoubleTap(context),
        child:

        loading is ValueNotifier<bool> ?
        ValueListenableBuilder(
          valueListenable: loading,
          child: _PyramidGraphic(pyramidType, color),
          builder: (_, bool loading, Widget child){

            return WidgetFader(
              fadeType: loading == true ? FadeType.repeatAndReverse : FadeType.fadeIn,
              duration: const Duration(milliseconds: 750),
              min: 0.4,
              child: child,
            );

          },
        )

            :

        loading is bool ?
        WidgetFader(
          fadeType: loading == true ? FadeType.repeatAndReverse : FadeType.fadeIn,
          duration: const Duration(milliseconds: 750),
          min: 0.4,
          child: _PyramidGraphic(pyramidType, color),
        )

            :

        WidgetFader(
          fadeType: FadeType.stillAtMax,
          duration: const Duration(milliseconds: 400),
          min: 0.4,
          child: _PyramidGraphic(pyramidType, color),
        )

    );

  }
  /// --------------------------------------------------------------------------
}


class _PyramidGraphic extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PyramidGraphic(
      this.pyramidType, this.color,
      {Key key}
      ) : super(key: key);
  // -----------------------------------------------------------------------------
  final PyramidType pyramidType;
  final Color color;
  // -----------------------------------------------------------------------------
  String getPyramid(PyramidType type){

    switch (type){
      case PyramidType.yellow:        return Iconz.pyramidsYellow; break;
      case PyramidType.crystalYellow: return Iconz.pyramidzYellow; break;
      case PyramidType.white:         return Iconz.pyramidsWhite; break;
      case PyramidType.crystalWhite:  return Iconz.pyramidzWhite; break;
      case PyramidType.crystalBlue:   return Iconz.pyramidsCrystal; break;
      case PyramidType.glass:         return Iconz.pyramidsGlass; break;
      case PyramidType.non:           return null; break;
      default: return Iconz.pyramidzYellow;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    /// IF ADMIN
    if (_userModel?.isAdmin == true){

      final String _pyramidIcon = getPyramid(PyramidType.crystalYellow);

      return Stack(
        children: <Widget>[

          const SuperImage(
            width: 256 * 0.7,
            height: 80 * 0.7,
            iconColor: Colorz.black255,
            pic: Iconz.pyramidsWhiteClean,
            boxFit: BoxFit.fitWidth,
          ),

          SuperImage(
            width: 256 * 0.7,
            height: 80 * 0.7,
            pic: _pyramidIcon,
            iconColor: Colorz.red230,
            boxFit: BoxFit.fitWidth,
          ),

        ],
      );

    }

    /// IF USER
    else {

      final String _pyramidIcon = getPyramid(pyramidType);

      return SuperImage(
        width: 256 * 0.7,
        height: 80 * 0.7,
        iconColor: color,
        pic: _pyramidIcon,
        boxFit: BoxFit.fitWidth,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
