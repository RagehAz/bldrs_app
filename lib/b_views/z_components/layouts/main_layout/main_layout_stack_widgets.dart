import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/material.dart';

class MainLayoutStackWidgets extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayoutStackWidgets({
    @required this.alignment,
    @required this.skyType,
    @required this.layoutWidget,
    @required this.appBarType,
    @required this.appBarRowWidgets,
    @required this.pageTitleVerse,
    @required this.onBack,
    @required this.loading,
    @required this.progressBarModel,
    @required this.appBarScrollController,
    @required this.searchController,
    @required this.onSearchSubmit,
    @required this.onPaste,
    @required this.onSearchChanged,
    @required this.sectionButtonIsOn,
    @required this.historyButtonIsOn,
    @required this.pyramidsAreOn,
    @required this.searchHintVerse,
    @required this.pyramidType,
    @required this.onPyramidTap,
    @required this.canGoBack,
    @required this.onSearchCancelled,
    @required this.confirmButtonModel,
    @required this.globalKey,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Alignment alignment;
  final SkyType skyType;
  final Widget layoutWidget;
  final AppBarType appBarType;
  final List<Widget> appBarRowWidgets;
  final Verse pageTitleVerse;
  final Function onBack;
  // final bool loading;
  final ScrollController appBarScrollController;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onPaste;
  final ValueChanged<String> onSearchChanged;
  final bool pyramidsAreOn;
  final bool historyButtonIsOn;
  final bool sectionButtonIsOn;
  final Verse searchHintVerse;
  final ValueNotifier<bool> loading;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final PyramidType pyramidType;
  final Function onPyramidTap;
  final bool canGoBack;
  final Function onSearchCancelled;
  final ConfirmButtonModel confirmButtonModel;
  final GlobalKey globalKey;
  /// --------------------------------------------------------------------------
  PyramidType _concludePyramidTypePerSkyType(){

    if (pyramidType != null){
      return pyramidType;
    }

    else {

      if (skyType == SkyType.black){
        return PyramidType.crystalWhite;
      }

      else if (skyType == SkyType.night){
        return PyramidType.crystalYellow;
      }

      else if (skyType == SkyType.non){
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

    return Stack(
      key: key,
      alignment: alignment,
      children: <Widget>[


        if (skyType != SkyType.non)
          Sky(
            key: const ValueKey<String>('sky'),
            skyType: skyType,
            gradientIsOn: pyramidsAreOn,
          ),

        /// --- LAYOUT WIDGET
        if (layoutWidget != null)
          Container(
            key: const ValueKey<String>('layoutWidget'),
            width: Scale.screenWidth(context),
            // height: Scale.superScreenHeight(context),
            alignment: Alignment.topCenter,
            child: layoutWidget,
          ),

        /// --- APP BAR
        if (appBarType != AppBarType.non)
          BldrsAppBar(
            globalKey: globalKey,
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
            historyButtonIsOn: historyButtonIsOn,
            searchHintVerse: searchHintVerse,
            canGoBack: canGoBack,
            onSearchCancelled: onSearchCancelled,
          ),

        /// --- PYRAMIDS
        if (pyramidsAreOn == true && confirmButtonModel == null)
          Pyramids(
            key: const ValueKey<String>('pyramids'),
            pyramidType: _concludePyramidTypePerSkyType(),
            loading: loading,
            onPyramidTap: onPyramidTap,
          ),

        if (confirmButtonModel != null)
          Align(
            alignment: Aligners.superInverseBottomAlignment(context),
            child: ConfirmButton(
              confirmButtonModel: confirmButtonModel,
            ),
          ),

        /// --- IOS BACK BUTTON
        if (pyramidsAreOn == false && DeviceChecker.deviceIsIOS() == true)
          Positioned(
            key: const ValueKey<String>('backAndSearchButton'),
            bottom: 0,
            left: 0,
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goBack,
              color: skyType == SkyType.black ? Colorz.yellow50 : Colorz.white20,
            ),
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
