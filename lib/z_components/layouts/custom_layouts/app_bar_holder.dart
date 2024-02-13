import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/main_layout/pre_layout.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AppBarHolder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AppBarHolder({
    required this.child,
    required this.appBarType,
    this.onBack,
    this.searchController,
    this.onSearchSubmit,
    this.onPaste,
    this.onSearchChanged,
    this.searchButtonIsOn = true,
    this.searchHintVerse,
    this.loading,
    this.progressBarModel,
    this.onSearchCancelled,
    this.filtersAreOn,
    this.filters,
    this.canGoBack = true,
    this.listenToHideLayout = false,
    this.onTextFieldTap,
    this.onSearchButtonTap,
    super.key,
  });
  // --------------------
  final Widget child;
  final AppBarType appBarType;
  final Function? onBack;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final Verse? searchHintVerse;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final Function? onSearchCancelled;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  final bool canGoBack;
  final bool listenToHideLayout;
  final Function? onTextFieldTap;
  final Function? onSearchButtonTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Stack(
      key: const ValueKey<String>('HomeViewer'),
      children: <Widget>[

        child,

        /// APP BAR
        BldrsAppBar(
          appBarType: appBarType,
          appBarRowWidgets: null,
          pageTitleVerse: null,
          onBack: () => PreLayout.onGoBack(
            onBack: onBack,
            canGoBack: canGoBack,
          ),
          loading: loading,
          progressBarModel: progressBarModel,
          appBarScrollController: null,
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
          onSearchButtonTap: onSearchButtonTap,
          onTextFieldTap: onTextFieldTap,
          filters: filters,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
