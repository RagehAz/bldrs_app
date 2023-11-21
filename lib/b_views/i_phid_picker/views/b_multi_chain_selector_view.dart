import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/i_phid_picker/views/phids_search_view.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/slides_shelf/aaa_flyer_slides_shelf.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/phids_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class MultiChainSelectorView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MultiChainSelectorView({
    required this.globalKey,
    required this.navModels,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onSearchCancelled,
    required this.onSearchChanged,
    required this.isSearching,
    required this.foundChains,
    required this.onBack,
    required this.searchText,
    required this.selectedPhidsNotifier,
    required this.onPagePhidTap,
    required this.onPanelPhidTap,
    required this.selectedPhidsScrollController,
    required this.multipleSelectionMode,
    required this.flyerModel,
    super.key
  });
  // --------------------
  final List<NavModel>? navModels;
  final GlobalKey globalKey;
  final TextEditingController searchController;
  final void Function(String?)? onSearchSubmit;
  final Function? onSearchCancelled;
  final void Function(String?)? onSearchChanged;
  final ValueNotifier<bool>? isSearching;
  final ValueNotifier<List<Chain>> foundChains;
  final Function? onBack;
  final ValueNotifier<dynamic> searchText;
  final ValueNotifier<List<String>> selectedPhidsNotifier;
  final Function(String? path, String? phid)? onPagePhidTap;
  final Function(String? path, String? phid)? onPanelPhidTap;
  final ScrollController selectedPhidsScrollController;
  final bool multipleSelectionMode;
  final FlyerModel? flyerModel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ObeliskLayout(
      canSwipeBack: true,
      appBarIcon: null,
      globalKey: globalKey,
      navModels: navModels,
      canGoBack: true,
      appBarType: AppBarType.search,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      onSearchCancelled: onSearchCancelled,
      onSearchChanged: onSearchSubmit,
      isSearching: isSearching,
      onBack: onBack,
      searchHintVerse: const Verse(
        id: 'phid_search',
        translate: true,
      ),
      // appBarRowWidgets: <Widget>[
      //
      //   const Expander(),
      //
      //   AppBarButton(
      //     verse: Verse.plain('blogChains'),
      //     onTap: (){
      //       Chain.blogChains(_bldrsChains);
      //     },
      //   ),
      //
      // ],
      /// SEARCH VIEW
      searchView: PhidsSearchView(
        foundChains: foundChains,
        searchText: searchText,
        selectedPhidsNotifier: selectedPhidsNotifier,
        onPagePhidTap: onPagePhidTap,
      ),

      /// CORNER SELECTED PHIDS
      abovePyramidsChild: multipleSelectionMode == false ?
      const SizedBox()
          :
      CornerWidgetMaximizer(
        maxWidth: Bubble.bubbleWidth(context: context),
        minWidth: Scale.superWidth(context, 0.4),
        childWidth: Bubble.bubbleWidth(context: context),

        /// FLYER SHELF IN SELECTED PHIDS PANEL
        topChild: flyerModel == null ?
        const SizedBox()
            :
        FlyerSlidesShelf(
          flyerModel: flyerModel,
          shelfWidth: BldrsAppBar.clearWidth(context),
          slidePicType: SlidePicType.small,
        ),

        /// SELECTED PHIDS PANEL
        child: ValueListenableBuilder(
          valueListenable: selectedPhidsNotifier,
          builder: (BuildContext context, List<String>? selectedPhids, Widget? child) {

            final String? _selectedKeywords = getWord('phid_selected_keywords');

            final Verse _verse = Verse(
              id: '(${selectedPhids?.length}) $_selectedKeywords',
              translate: false,
            );

            return PhidsBubble(
              bubbleColor: Colorz.white10,
              selectedWords: selectedPhids,
              passPhidOnTap: true,
              titleVerse: _verse,
              phids: selectedPhids,
              addButtonIsOn: false,
              bubbleWidth: Bubble.bubbleWidth(context: context),
              maxLines: 3,
              scrollController: selectedPhidsScrollController,
              onPhidTap: (String phid) => onPanelPhidTap?.call(null, phid),
            );

          },
        ),

      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
