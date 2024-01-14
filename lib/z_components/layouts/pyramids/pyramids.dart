// ignore_for_file: unused_element
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/layouts/pyramids/khufu.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // --------------------------------------------------------------------------
  const Pyramids({
    required this.pyramidType,
    this.loading,
    this.onPyramidTap,
    this.color,
    this.putInCorner = true,
    this.listenToHideLayout,
    this.onPyramidDoubleTap,
    this.isSinglePyramid = false,
    this.canShowArrow = true,
    super.key
  });
  // --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function? onPyramidTap;
  final Color? color;
  final bool putInCorner;
  final bool? listenToHideLayout;
  final bool isSinglePyramid;
  final void Function()? onPyramidDoubleTap;
  final bool canShowArrow;
  // --------------------------------------------------------------------------
  static const double verticalPositionFix = -0.2;
  // --------------------------------------------------------------------------
  static const double width = 256 * 0.7;
  static const double height = 80 * 0.7;
  // --------------------
  static const double rightMargin = 17 * 0.7;
  // --------------------
  static const double rightSpaceToCenterKhufu = 148.2 * 0.7;
  static const double rightSpaceToCenterKhafre = 74.2 * 0.7;
  // --------------------

  static const khafreHeight = 66.4 * 0.7;
  static const khafreWidth = 143.1 * 0.7;
  static const leftSpaceToKhafreTip = 68.9 * 0.7;
  static const rightSpaceToKhafreTip = 74.2 * 0.7;
  static const leftSpaceToKhafreBase = 46 * 0.7;
  static const rightSpaceToKhafreBase = 97.1 * 0.7;

  static const leftSpaceToKhufuBase = 38 * 0.7;
  // --------------------
  static const Offset khufuTip = Offset(
    rightMargin + rightSpaceToCenterKhufu,
    height,
  );
  // --------------------
  static const Offset khafreTip = Offset(
    rightMargin + rightSpaceToCenterKhafre,
    khafreHeight,
  );

  static Color yellow = Colorz.yellow255;
  static Color white = Colorz.white255;
  static Color black = const Color.fromRGBO(15, 15, 15, 1);
  static Color crystalYellowFront = Colorz.yellow255.withOpacity(0.1);
  static Color crystalYellowSide = Colorz.yellow255.withOpacity(0.2);
  // --------------------------------------------------------------------------
  static String? getPyramid(PyramidType? type){

    switch (type){
      case PyramidType.yellow:        return Iconz.pyramidsYellow;
      case PyramidType.crystalYellow: return Iconz.pyramidzYellow;
      case PyramidType.white:         return Iconz.pyramidsWhite;
      case PyramidType.crystalWhite:  return Iconz.pyramidzWhite;
      case PyramidType.crystalBlue:   return Iconz.pyramidsCrystal;
      case PyramidType.glass:         return Iconz.pyramidsGlass;
      case PyramidType.non:           return null;
      default: return Iconz.pyramidzYellow;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Widget pyramidsWidget = _PyramidsSwitcher(
      pyramidType: pyramidType,
      loading: loading,
      onPyramidTap: onPyramidTap,
      color: color,
      putInCorner: putInCorner,
      listenToHideLayout: listenToHideLayout,
      onPyramidDoubleTap: onPyramidDoubleTap,
      isSinglePyramid: isSinglePyramid,
      canShowArrow: canShowArrow,
    );
    // --------------------
    if (putInCorner == true){
      return Positioned(
        bottom: isSinglePyramid == true ? 0 : Pyramids.verticalPositionFix,
        right: rightMargin,
        child: pyramidsWidget,
      );
    }
    // --------------------
    else {
      return pyramidsWidget;
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _PyramidsSwitcher extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PyramidsSwitcher({
    required this.pyramidType,
    required this.loading,
    required this.onPyramidTap,
    required this.color,
    required this.putInCorner,
    required this.listenToHideLayout,
    required this.onPyramidDoubleTap,
    required this.isSinglePyramid,
    required this.canShowArrow,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function? onPyramidTap;
  final Color? color;
  final bool putInCorner;
  final bool? listenToHideLayout;
  final bool isSinglePyramid;
  final void Function()? onPyramidDoubleTap;
  final bool canShowArrow;
  // -----------------------------------------------------------------------------
  static bool pyramidCanBeTapped(PyramidType type){

    switch(type){

      case PyramidType.yellow:        return true;
      case PyramidType.white:         return true;

      case PyramidType.crystalYellow: return false;
      case PyramidType.crystalWhite:  return false;
      case PyramidType.crystalBlue:   return false;
      case PyramidType.glass:         return false;
      case PyramidType.non:           return false;

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (listenToHideLayout == false){
      return IgnorePointer(
        ignoring: pyramidCanBeTapped(pyramidType) == false,
        child: _PyramidsWidgetTree(
          pyramidType: pyramidType,
          loading: loading,
          onPyramidTap: onPyramidTap,
          color: color,
          putInCorner: putInCorner,
          onPyramidDoubleTap: onPyramidDoubleTap,
          isSinglePyramid: isSinglePyramid,
          canShowArrow: canShowArrow,
        ),
      );
    }

    else {

      return Selector<UiProvider, bool>(
        selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
        builder: (_, bool isVisible, Widget? child) {

          return IgnorePointer(
            ignoring: (!isVisible) || pyramidCanBeTapped(pyramidType) == false,
            child: WidgetFader(
              fadeType: isVisible == false ? FadeType.fadeOut : FadeType.fadeIn,
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
          );

        },

        child: _PyramidsWidgetTree(
          pyramidType: pyramidType,
          loading: loading,
          onPyramidTap: onPyramidTap,
          color: color,
          putInCorner: putInCorner,
          onPyramidDoubleTap: onPyramidDoubleTap,
          isSinglePyramid: isSinglePyramid,
          canShowArrow: canShowArrow,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _PyramidsWidgetTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PyramidsWidgetTree({
    required this.pyramidType,
    required this.loading,
    required this.color,
    required this.putInCorner,
    required this.onPyramidTap,
    required this.onPyramidDoubleTap,
    required this.isSinglePyramid,
    required this.canShowArrow,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Color? color;
  final bool putInCorner;
  final Function? onPyramidTap;
  final void Function()? onPyramidDoubleTap;
  final bool isSinglePyramid;
  final bool canShowArrow;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NEW
    return GestureDetector(
      onTap: onPyramidTap == null ? null : () => onPyramidTap?.call(),
      onDoubleTap: onPyramidDoubleTap,
      child: _PyramidsLoadingChecker(
        loading: loading,
        builder: (bool isLoading){

          return WidgetFader(
            fadeType: isLoading == true ? FadeType.repeatAndReverse : FadeType.fadeIn,
            duration: const Duration(milliseconds: 600),
            min: 0.4,
            child: _PyramidGraphic(
              pyramidType: pyramidType,
              color: color,
              isLoading: isLoading,
              isSinglePyramid: isSinglePyramid,
              onPyramidTap: onPyramidTap,
              onPyramidDoubleTap: onPyramidDoubleTap,
              canShowArrow: canShowArrow,
            ),
          );

          },

      ),
    );

  }
  /// --------------------------------------------------------------------------
}

class _PyramidGraphic extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PyramidGraphic({
    required this.onPyramidTap,
    required this.onPyramidDoubleTap,
    required this.canShowArrow,
    this.pyramidType,
    this.color,
    this.isLoading = false,
    this.isSinglePyramid = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final PyramidType? pyramidType;
  final Color? color;
  final bool isLoading;
  final bool isSinglePyramid;
  final Function? onPyramidTap;
  final void Function()? onPyramidDoubleTap;
  final bool canShowArrow;
  // -----------------------------------------------------------------------------
  bool _canShowArrow(){
    bool _output = false;

    if (canShowArrow == true){
      if (pyramidType == PyramidType.white || pyramidType == PyramidType.yellow){
        _output = true;
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Column(
        children: [

          /// TRIANGLE
          if (_canShowArrow() == true)
          _PyramidArrow(
            singlePyramid: isSinglePyramid,
          ),

          /// MULTI PYRAMID
          if (isSinglePyramid == false)
            GestureDetector(
              onTap: onPyramidTap == null ? null : () => onPyramidTap?.call(),
              onDoubleTap: onPyramidDoubleTap,
              child: BldrsImage(
                width: 256 * 0.7,
                height: 80 * 0.7,
                iconColor: color,
                pic: Pyramids.getPyramid(pyramidType),
                fit: BoxFit.fitWidth,
              ),
            ),

          if (isSinglePyramid == true)
            Khufu(
              frontColor: (){

                switch(pyramidType){
                  case PyramidType.yellow: return Pyramids.yellow;
                  case PyramidType.crystalYellow: return Pyramids.crystalYellowFront;
                  case PyramidType.white: return Pyramids.white;
                  case PyramidType.crystalWhite: return Colorz.white10;
                  case PyramidType.crystalBlue: return Colorz.blue50;
                  case PyramidType.glass: return Colorz.white20;
                  default: return null;
                }

              }(),
              backColor: (){

                switch(pyramidType){
                  case PyramidType.yellow: return Pyramids.black;
                  case PyramidType.crystalYellow: return Pyramids.crystalYellowSide;
                  case PyramidType.white: return Pyramids.black;
                  case PyramidType.crystalWhite: return Colorz.white50;
                  case PyramidType.crystalBlue: return Colorz.blue20;
                  case PyramidType.glass: return Colorz.white50;
                  default: return null;
                }
              }(),
              splashColor: (){

                switch(pyramidType){
                  case PyramidType.yellow: return Colorz.black125;
                  case PyramidType.white: return Colorz.black125;
                  // case PyramidType.crystalYellow: null;
                  // case PyramidType.crystalWhite: return null;
                  // case PyramidType.crystalBlue: return null;
                  // case PyramidType.glass: return null;
                  default: return null;
                }

              }(),
              onTap: onPyramidTap == null ? null : () => onPyramidTap?.call(),
              onDoubleTap: onPyramidDoubleTap,
            ),

        ],
      );

  }
  // -----------------------------------------------------------------------------
}

bool imAdmin(BuildContext context){
  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: true,
  );
  return _userModel?.isAdmin ?? false;
}

class _PyramidsLoadingChecker extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PyramidsLoadingChecker({
    required this.loading,
    required this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic loading;
  final Widget Function(bool isLoading) builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (loading is ValueNotifier<bool>){
      return ValueListenableBuilder(
        valueListenable: loading,
        builder: (_, bool isLoading, Widget? child){
          return builder(isLoading);
          },
      );
    }
    // --------------------
    else if (loading is bool){
      return builder(loading);
    }
    // --------------------
    else {
      return builder(false);
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _PyramidArrow extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PyramidArrow({
    required this.singlePyramid,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool singlePyramid;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
        key: const ValueKey<String>('_RedTriangle'),
        selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
        builder: (_, bool? expanded, Widget? child) {

          final bool _isExpanded = Mapper.boolIsTrue(expanded);

          return Selector<NotesProvider, bool>(
              selector: (_,NotesProvider notesProvider) => notesProvider.isFlashing,
              builder: (_, bool isFlashing, Widget? child){

                /// PYRAMID IS EXPANDED
                if (_isExpanded == true){
                  return const SizedBox();
                }

                /// PYRAMID IS NOT FLASHING
                else if (isFlashing == false){
                  return const SizedBox();
                }

                /// MILTIPLE PYRAMIDS
                else if (singlePyramid == false){
                  return IgnorePointer(
                    child: Container(
                      width: 256 * 0.7,
                      height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                          right: 136.2 * 0.7
                      ),
                      child: WidgetFader(
                        fadeType: FadeType.repeatForwards,
                        duration: const Duration(milliseconds: 600),
                        builder: (double value, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0, value * 10),
                            child: child,
                          );
                          },
                        child: const RotatedBox(
                          quarterTurns: 2,
                          child: BldrsImage(
                            width: 25 * 0.7,
                            height: 25 * 0.7,
                            pic: Iconz.pyramidSingleYellow,
                            corners: 0,
                            // iconColor: Colorz.red255,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                /// SINGLE PYRAMID
                else {
                  return IgnorePointer(
                    child: Container(
                      width: Pyramids.khafreWidth,
                      height: Pyramids.khafreHeight,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                          right: Pyramids.rightSpaceToCenterKhafre - (25 * 0.7 * 0.45),
                      ),
                      child: WidgetFader(
                        fadeType: FadeType.repeatForwards,
                        duration: const Duration(milliseconds: 600),
                        builder: (double value, Widget? child) {
                          return Transform.translate(
                            offset: Offset(0, value * 10),
                            child: child,
                          );
                        },
                        child: const RotatedBox(
                          quarterTurns: 2,
                          child: BldrsImage(
                            width: 25 * 0.7,
                            height: 25 * 0.7,
                            pic: Iconz.pyramidSingleYellow,
                            corners: 0,
                            // iconColor: Colorz.red255,
                          ),
                        ),
                      ),
                    ),
                  );
                }

              }
              );

        }
        );

  }
  // -----------------------------------------------------------------------------
}
