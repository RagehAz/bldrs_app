import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PickersScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersScreenSearchView({
    @required this.screenHeight,
    @required this.foundChains,
    @required this.selectedSpecs,
    @required this.searchText,
    @required this.onSelectPhid,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.onSpecTap,
    @required this.onDeleteSpec,
    @required this.onPickerTap,
    @required this.refinedPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final ValueNotifier<String> searchText;
  final Function(String path, String phid) onSelectPhid;
  final ZoneModel zone;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  final ValueNotifier<List<PickerModel>> refinedPickers;
  final Function({@required SpecModel value, @required SpecModel unit}) onSpecTap;
  final Function({@required SpecModel value, @required SpecModel unit}) onDeleteSpec;
  final ValueChanged<PickerModel> onPickerTap;
/// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ChainsScreenSearchView'),
        valueListenable: foundChains,
        builder: (_, List<Chain> _foundChains, Widget childB){

          final bool _noResultsFound = Mapper.checkCanLoopList(_foundChains) == false;

          /// NO RESULT FOUND
          if (_noResultsFound == true){
            return PageBubble(
              screenHeightWithoutSafeArea: screenHeight,
              appBarType: AppBarType.search,
              child: const NoResultFound(),
            );
          }

          else {

            return ValueListenableBuilder(
                valueListenable: refinedPickers,
                builder: (_, List<PickerModel> allPickers, Widget child){

                  final List<PickerModel> _pickers = PickerModel.getPickersByChainsIDs(
                    chainsIDs: Chain.getChainsIDs(_foundChains),
                    pickers: allPickers,
                  );

                  return PageBubble(
                    screenHeightWithoutSafeArea: screenHeight,
                    appBarType: AppBarType.search,
                    color: Colorz.white20,
                    child: ValueListenableBuilder(
                      valueListenable: selectedSpecs,
                      builder: (_, List<SpecModel> _selectedSpecs, Widget child){

                        // return ListView.builder(
                        //     itemCount: _pickers.length,
                        //     physics: const BouncingScrollPhysics(),
                        //     padding: const EdgeInsets.only(
                        //       top: Stratosphere.bigAppBarStratosphere,
                        //       bottom: Ratioz.horizon,
                        //     ),
                        //     itemBuilder: (BuildContext ctx, int index) {
                        //
                        //       final PickerModel _picker = _pickers[index];
                        //
                        //       return PickerSplitter(
                        //         picker: _picker,
                        //         onDeleteSpec: onDeleteSpec,
                        //         onSpecTap: onSpecTap,
                        //         allSelectedSpecs: _selectedSpecs,
                        //         onTap: () => onPickerTap(_picker),
                        //       );
                        //
                        //     }
                        // );

                        return ChainSplitter(
                          chainOrChainsOrSonOrSons: _foundChains,
                          width: PageBubble.clearWidth(context) + 20,
                          selectedPhids: SpecModel.getSpecsIDs(_selectedSpecs),
                          initiallyExpanded: true,
                          searchText: searchText,
                          secondLinesType: ChainSecondLinesType.non,
                          onPhidTap: onSelectPhid,
                          onPhidDoubleTap: (String path, String phid) => blog('ChainsScreenSearchView : onPhidDoubleTap : $path : $phid'),
                          onPhidLongTap: (String path, String phid) => blog('ChainsScreenSearchView : onPhidLongTap : $path : $phid'),
                          onExportSpecs: (List<SpecModel> specs) => blog('ChainsScreenSearchView : specs : ${specs.length} specs'),
                          isMultipleSelectionMode: isMultipleSelectionMode,
                          onlyUseCityChains: onlyUseCityChains,
                          zone: zone,
                          onDataCreatorKeyboardSubmitted: (String text){blog('fuck this $text');},
                        );

                      },
                    ),
                  );

                }
            );

          }

        }
    );

  }
  // -----------------------------------------------------------------------------
}
