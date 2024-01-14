import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/x_picker_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/picker_splitter.dart';
import 'package:bldrs/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';

class PickersScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersScreenSearchView({
    required this.screenHeight,
    required this.foundChains,
    required this.selectedSpecsNotifier,
    required this.searchText,
    required this.zone,
    required this.onlyUseZoneChains,
    required this.isMultipleSelectionMode,
    required this.refinedPickersNotifier,
    required this.allPickers,
    required this.mounted,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<List<SpecModel>> selectedSpecsNotifier;
  final ValueNotifier<String?> searchText;
  final ZoneModel? zone;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final ValueNotifier<List<PickerModel>> refinedPickersNotifier;
  final List<PickerModel> allPickers;
  final bool mounted;
/// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('PickersScreenSearchView'),
        valueListenable: foundChains,
        builder: (_, List<Chain> _foundChains, Widget? childB){

          final bool _noResultsFound = Lister.checkCanLoop(_foundChains) == false;

          /// NO RESULT FOUND
          if (_noResultsFound == true){
            return const Center(
                child: NoResultFound(),
            );
          }

          /// RESULT FOUND
          else {

            return PageBubble(
              screenHeightWithoutSafeArea: screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.white10,
              child: ValueListenableBuilder(
                valueListenable: selectedSpecsNotifier,
                builder: (_, List<SpecModel> _selectedSpecs, Widget? child){

                  return ListView.separated(
                      itemCount: _foundChains.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: Ratioz.appBarMargin,
                        bottom: Ratioz.horizon,
                        left: Ratioz.appBarMargin,
                        right: Ratioz.appBarMargin,
                      ),
                      separatorBuilder: (_, int i){
                        return const SizedBox(
                          width: Ratioz.appBarPadding,
                          height: Ratioz.appBarPadding,
                        );
                      },
                      itemBuilder: (BuildContext ctx, int index) {

                        final Chain _chain = _foundChains[index];

                        final PickerModel? _picker = ChainsProvider.proGetPickerByChainID(
                          chainID: _chain.id,
                        );


                        // final PickerModel _picker = _pickers[index];

                        blog('x $index : ${_chain.id} : ${_picker?.chainID} : ${_picker?.unitChainID} : <-------------');
                        //
                        // final Chain _chain = ChainsProvider.proGetChainByID(
                        //   context: context,
                        //   chainID: _picker.chainID,
                        // );

                        if (_picker == null){
                          return const SizedBox();
                        }

                        else if (DataCreation.checkIsDataCreator(_chain.sons) == true){
                          return PickerSplitter(
                            width: PageBubble.clearWidth(context),
                            picker: _picker,
                            searchText: searchText,
                            allSelectedSpecs: _selectedSpecs,
                            onDeleteSpec: ({SpecModel? value, SpecModel? unit}) => onRemoveSpecs(
                              valueSpec: value,
                              unitSpec: unit,
                              pickers: allPickers,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                              mounted: mounted,
                            ),
                            onSelectedSpecTap: ({SpecModel? value, SpecModel? unit}){
                              blog('a 77 aaa ChainsPickingScreen : onSpecTap');
                              value?.blogSpec();
                              unit?.blogSpec();
                            },
                            onPickerTap: () => onGoToPickerScreen(
                              context: context,
                              zone: zone,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                              isMultipleSelectionMode: isMultipleSelectionMode,
                              onlyUseZoneChains: onlyUseZoneChains,
                              allPickers: allPickers,
                              picker: _picker,
                              refinedPickersNotifier: refinedPickersNotifier,
                              mounted: mounted,
                            ),
                          );
                        }

                        else {

                          return ChainSplitter(
                            width: PageBubble.clearWidth(context),
                            chainOrChainsOrSonOrSons: _chain,
                            selectedPhids: SpecModel.getSpecsIDs(_selectedSpecs),
                            initiallyExpanded: true,
                            searchText: searchText,
                            secondLinesType: ChainSecondLinesType.non,
                            isMultipleSelectionMode: isMultipleSelectionMode,
                            onlyUseZoneChains: onlyUseZoneChains,
                            zone: zone,

                            /// ON PHID TAP => ADD PHID
                            onPhidTap: (String? path, String? phid) => onSelectPhidInPickerScreen(
                              context: context,
                              mounted: mounted,
                              phid: phid,
                              isMultipleSelectionMode: isMultipleSelectionMode,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                              picker: PickerModel.getPickerByChainID(
                                pickers: allPickers,
                                chainID: Pathing.getFirstPathNode(path: Phider.removePathIndexes(path)),
                              ),
                            ),


                            onPhidDoubleTap: (String? path, String? phid) => blog('ChainsScreenSearchView : onPhidDoubleTap : $path : $phid'),
                            onPhidLongTap: (String? path, String? phid) => blog('ChainsScreenSearchView : onPhidLongTap : $path : $phid'),
                            onExportSpecs: (List<SpecModel> specs) => blog('ChainsScreenSearchView : specs : ${specs.length} specs'),
                            onDataCreatorKeyboardSubmitted: (String? text){
                              blog('fuck this $text');

                              /*
                            onDataCreatorKeyboardSubmittedAnd(
                              context: context,
                              formKey: GlobalKey<FormState>(),
                              specValue: ValueNotifier(12),
                              dataCreatorType: _dataCreator,
                              text: text,
                              selectedUnitID: null,
                              picker: _picker,
                              onExportSpecs: (List<SpecModel> specs){
                                SpecModel.blogSpecs(specs);
                              },
                            )

                             */

                            },
                            isCollapsable: true,
                          );
                        }


                      }
                  );


                },
              ),
            );

          }

        }
    );

  }
  // -----------------------------------------------------------------------------
}
