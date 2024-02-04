import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class LineWithSearchbar extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LineWithSearchbar({
    required this.searchController,
    required this.onSearchSubmit,
    required this.onSearchChanged,
    required this.hintVerse,
    required this.onSearchCancelled,
    this.onTextFieldTap,
    this.onSearchButtonTap,
    super.key
  });
  // --------------------
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onSearchChanged;
  final Verse? hintVerse;
  final Function? onSearchCancelled;
  final Function? onTextFieldTap;
  final Function? onSearchButtonTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    const double _spacing = Ratioz.appBarPadding;
    final double _searchBarWidth = _clearWidth - _spacing - Ratioz.appBarButtonSize;

    return Container(
      height: BldrsAppBar.clearLineHeight(context),
      width: BldrsAppBar.clearWidth(context),
      // color: Colorz.bloodTest,
      margin: const EdgeInsets.symmetric(
        vertical: Ratioz.appBarPadding,
      ),
      child: Row(
        children: <Widget>[

          /// SEARCH ICON
          BldrsBox(
            height: Ratioz.appBarButtonSize,
            width: Ratioz.appBarButtonSize,
            corners: Ratioz.appBarButtonCorner,
            // margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            icon: Iconz.search,
            color: Colorz.white10,
            iconSizeFactor: 0.5,
            bubble: false,
            // textDirection: superInverseTextDirection(context),
            onTap: onSearchButtonTap,
          ),

          /// STARTING SPACER
          const SizedBox(
            width: _spacing,
            height: _spacing,
          ),

          /// SEARCH BAR
          BldrsSearchBar(
            searchController: searchController,
            onSearchSubmit: onSearchSubmit,
            onSearchChanged: onSearchChanged,
            onSearchCancelled: onSearchCancelled,
            searchButtonIsOn: false,
            hintVerse: hintVerse,
            width: _searchBarWidth,
            height: Ratioz.appBarButtonSize,
            appBarType: AppBarType.non,
            onTextFieldTap: onTextFieldTap,
            // onPaste: null,
            // filtersAreOn: null,
            onFilterTap: (){

              // if (filtersAreOn != null){
              //
              //   setNotifier(
              //     notifier: filtersAreOn,
              //     mounted: true,
              //     value: !Mapper.boolIsTrue(filtersAreOn?.value),
              //   );
              //
              // }

            },
          ),

          // const SizedBox(width: Ratioz.appBarPadding),
        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
