import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/navigation/layout_exit_swiper.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class MainLayoutStackWidgets extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayoutStackWidgets({
    required this.alignment,
    required this.skyType,
    required this.layoutWidget,
    required this.appBarType,
    required this.appBarRowWidgets,
    required this.pageTitleVerse,
    required this.onBack,
    required this.loading,
    required this.progressBarModel,
    required this.appBarScrollController,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onPaste,
    required this.onSearchChanged,
    required this.sectionButtonIsOn,
    required this.searchButtonIsOn,
    required this.pyramidsAreOn,
    required this.searchHintVerse,
    required this.pyramidType,
    required this.onPyramidTap,
    required this.canGoBack,
    required this.canSwipeBack,
    required this.onSearchCancelled,
    required this.confirmButton,
    required this.listenToHideLayout,
    required this.filtersAreOn,
    required this.filters,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Alignment alignment;
  final SkyType skyType;
  final Widget? layoutWidget;
  final AppBarType? appBarType;
  final List<Widget>? appBarRowWidgets;
  final Verse? pageTitleVerse;
  final Function onBack;
  // final bool loading;
  final ScrollController? appBarScrollController;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool pyramidsAreOn;
  final bool searchButtonIsOn;
  final bool sectionButtonIsOn;
  final Verse? searchHintVerse;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final PyramidType? pyramidType;
  final Function? onPyramidTap;
  final bool canGoBack;
  final bool canSwipeBack;
  final Function? onSearchCancelled;
  final Widget? confirmButton;
  final bool listenToHideLayout;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  /// --------------------------------------------------------------------------
  PyramidType _concludePyramidTypePerSkyType(){

    if (pyramidType != null){
      return pyramidType!;
    }

    else {

      if (skyType == SkyType.grey){
        return PyramidType.crystalWhite;
      }

      else if (skyType == SkyType.black){
        return PyramidType.crystalYellow;
      }

      else if (skyType == SkyType.black){
        return PyramidType.crystalBlue;
      }

      else {
        return PyramidType.glass;
      }

    }


  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    assert(
        progressBarModel == null && loading == null
        ||
        progressBarModel == null && loading != null
        ||
        progressBarModel != null && loading != null,
    'you have to use the loading parameter when adding progressBarModel');

    /// NEW TEST
    return LayoutExitSwiper(
      isOn: canSwipeBack,
      onBack: onBack,
      child: Stack(
        key: key,
        alignment: alignment,
        children: <Widget>[

          /// SKY
          Sky(
            key: const ValueKey<String>('sky'),
            skyType: skyType,
            gradientIsOn: pyramidsAreOn,
          ),

          /// LAYOUT WIDGET
          if (layoutWidget != null)
            Container(
              key: const ValueKey<String>('layoutWidget'),
              width: Scale.screenWidth(context),
              // height: Scale.superScreenHeight(context),
              alignment: Alignment.topCenter,
              child: layoutWidget,
            ),

          /// APP BAR
          if (appBarType != AppBarType.non)
            BldrsAppBar(
              key: const ValueKey<String>('appBar'),
              appBarType: appBarType,
              appBarRowWidgets: appBarRowWidgets,
              pageTitleVerse: pageTitleVerse,
              onBack: onBack,
              loading: loading,
              progressBarModel: progressBarModel,
              appBarScrollController: appBarScrollController,
              sectionButtonIsOn: sectionButtonIsOn,
              searchController: searchController,
              onSearchSubmit: onSearchSubmit,
              onPaste: onPaste,
              onSearchChanged: onSearchChanged,
              searchButtonIsOn: searchButtonIsOn,
              searchHintVerse: searchHintVerse,
              canGoBack: canGoBack,
              onSearchCancelled: onSearchCancelled,
              listenToHideLayout: listenToHideLayout,
              filtersAreOn: filtersAreOn,
              filters: filters,
            ),

          /// PYRAMIDS
          if (pyramidsAreOn == true && confirmButton == null)
            Pyramids(
              key: const ValueKey<String>('pyramids'),
              pyramidType: _concludePyramidTypePerSkyType(),
              loading: loading,
              onPyramidTap: onPyramidTap,
              listenToHideLayout: listenToHideLayout,
            ),

          /// CONFIRM BUTTON
          if (confirmButton != null)
            confirmButton!,

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
