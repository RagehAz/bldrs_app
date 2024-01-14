import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_builder_page.dart';
import 'package:bldrs/b_views/i_phid_picker/views/phids_search_view.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class SingleChainSelectorView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SingleChainSelectorView({
    required this.searchController,
    required this.onSearchSubmit,
    required this.onSearchCancelled,
    required this.onSearchChanged,
    required this.isSearching,
    required this.foundChains,
    required this.searchText,
    required this.selectedPhidsNotifier,
    required this.onPagePhidTap,
    required this.chain,
    required this.onConfirmSelections,
    required this.onCancelSelections,
    required this.selectedPhids,
    required this.multipleSelectionMode,
    super.key
  });
  // --------------------
  final TextEditingController searchController;
  final void Function(String?)? onSearchSubmit;
  final Function? onSearchCancelled;
  final void Function(String?)? onSearchChanged;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<dynamic> searchText;
  final ValueNotifier<List<String>> selectedPhidsNotifier;
  final Function(String? path, String? phid)? onPagePhidTap;
  final Chain? chain;
  final Function onConfirmSelections;
  final Function? onCancelSelections;
  final List<String>? selectedPhids;
  final bool multipleSelectionMode;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.search,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      onSearchCancelled: onSearchCancelled,
      onSearchChanged: onSearchSubmit,
      skyType: SkyType.grey,
      onBack: onCancelSelections,
      title: const Verse(
        id: 'phid_select_keywords',
        translate: true,
      ),
      searchHintVerse: const Verse(
        id: 'phid_search',
        translate: true,
      ),
      confirmButton: multipleSelectionMode == false ? null : ValueListenableBuilder(
        valueListenable: selectedPhidsNotifier,
        builder: (context, List<String> phids, Widget? child) {

          final bool _identical = Lister.checkListsAreIdentical(
            list1: selectedPhids,
            list2: phids,
          );

          return ConfirmButton.button(
            // enAlignment: ,
            firstLine: const Verse(id: 'phid_confirm_selections', translate: true),
            secondLine: Verse(
              id: '${phids.length} ${getWord('phid_keyword')}',
              translate: false,
            ),
            isWide: true,
            onSkipTap: onCancelSelections,
            onTap: onConfirmSelections,
            isDisabled: _identical,
          );

        }
      ),
      child: ValueListenableBuilder(
        valueListenable: isSearching,
        builder: (context, bool searching, Widget? child) {

          if (searching == true){
            return PhidsSearchView(
              foundChains: foundChains,
              searchText: searchText,
              selectedPhidsNotifier: selectedPhidsNotifier,
              onPagePhidTap: onPagePhidTap,
            );
          }

          else if (chain == null){
            return const SizedBox();
          }

          else {
            return PhidsBuilderPage(
              chain: chain!,
              searchText: searchText,
              selectedPhidsNotifier: selectedPhidsNotifier,
              onPhidTap: onPagePhidTap,
            );
          }

        }
      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
