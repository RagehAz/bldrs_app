// ignore_for_file: unused_element
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
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
    super.key
  });
  // --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function? onPyramidTap;
  final Color? color;
  final bool putInCorner;
  final bool? listenToHideLayout;
  final void Function()? onPyramidDoubleTap;
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
    );
    // --------------------
    if (putInCorner == true){
      return Positioned(
        bottom: Pyramids.verticalPositionFix,
        right: 17 * 0.7,
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
    super.key
  });
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function? onPyramidTap;
  final Color? color;
  final bool putInCorner;
  final bool? listenToHideLayout;
  final void Function()? onPyramidDoubleTap;
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
    required this.onPyramidTap,
    required this.color,
    required this.putInCorner,
    required this.onPyramidDoubleTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final dynamic loading;
  final Function? onPyramidTap;
  final Color? color;
  final bool putInCorner;
  final void Function()? onPyramidDoubleTap;
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
            ),
          );

          },

      ),
    );

    /// OLD
    // return GestureDetector(
    //     onTap: onPyramidTap == null ? null : () => onPyramidTap?.call(),
    //     onDoubleTap: onPyramidDoubleTap,
    //     child:
    //
    //     loading is ValueNotifier<bool> ?
    //     ValueListenableBuilder(
    //       valueListenable: loading,
    //       // child: _PyramidGraphic(PyramidType pyramidType, color),
    //       builder: (_, bool loading, Widget? child){
    //
    //         return WidgetFader(
    //           fadeType: loading == true ? FadeType.repeatAndReverse : FadeType.fadeIn,
    //           duration: const Duration(milliseconds: 600),
    //           min: 0.4,
    //           child: child,
    //         );
    //
    //       },
    //       child: _PyramidGraphic(
    //         pyramidType: pyramidType,
    //         color: color,
    //       ),
    //     )
    //
    //         :
    //
    //     loading is bool ?
    //     WidgetFader(
    //       fadeType: loading == true ? FadeType.repeatAndReverse : FadeType.fadeIn,
    //       duration: const Duration(milliseconds: 600),
    //       min: 0.4,
    //       child: _PyramidGraphic(
    //           pyramidType: pyramidType,
    //           color: color,
    //       ),
    //     )
    //
    //         :
    //
    //     WidgetFader(
    //       fadeType: FadeType.stillAtMax,
    //       duration: const Duration(milliseconds: 400),
    //       min: 0.4,
    //       child: _PyramidGraphic(
    //           pyramidType: pyramidType,
    //           color: color,
    //       ),
    //     )
    //
    // );

  }
  /// --------------------------------------------------------------------------
}

class _PyramidGraphic extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PyramidGraphic({
    this.pyramidType,
    this.color,
    this.isLoading = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final PyramidType? pyramidType;
  final Color? color;
  final bool isLoading;
  // -----------------------------------------------------------------------------
  String? getPyramid(PyramidType? type){

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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      final String? _pyramidIcon = getPyramid(pyramidType);

      return Column(
        children: [

          /// TRIANGLE
          if (pyramidType == PyramidType.white || pyramidType == PyramidType.yellow)
          const _PyramidArrow(),

          /// PYRAMID
          BldrsImage(
            width: 256 * 0.7,
            height: 80 * 0.7,
            iconColor: color,
            pic: _pyramidIcon,
            fit: BoxFit.fitWidth,
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
    super.key
  });
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

                if (_isExpanded == true){
                  return const SizedBox();
                }

                else if (isFlashing == false){
                  return const SizedBox();
                }

                else {
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

              }
              );

        }
        );

  }
  // -----------------------------------------------------------------------------
}
