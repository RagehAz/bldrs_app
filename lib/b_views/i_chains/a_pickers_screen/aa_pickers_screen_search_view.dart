import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/x_picker_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/picker_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PickersScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersScreenSearchView({
    @required this.screenHeight,
    @required this.foundChains,
    @required this.selectedSpecsNotifier,
    @required this.searchText,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.refinedPickersNotifier,
    @required this.allPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<List<Chain>> foundChains;
  final ValueNotifier<List<SpecModel>> selectedSpecsNotifier;
  final ValueNotifier<String> searchText;
  final ZoneModel zone;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  final ValueNotifier<List<PickerModel>> refinedPickersNotifier;
  final List<PickerModel> allPickers;
/// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('PickersScreenSearchView'),
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

            return PageBubble(
              screenHeightWithoutSafeArea: screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.white10,
              child: ValueListenableBuilder(
                valueListenable: selectedSpecsNotifier,
                builder: (_, List<SpecModel> _selectedSpecs, Widget child){

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

                        final PickerModel _picker = ChainsProvider.proGetPickerByChainID(
                          chainID: _chain.id,
                          context: context,
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
                            onDeleteSpec: ({SpecModel value, SpecModel unit}) => onRemoveSpecs(
                              valueSpec: value,
                              unitSpec: unit,
                              pickers: allPickers,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                            ),
                            onSelectedSpecTap: ({SpecModel value, SpecModel unit}){
                              blog('a 77 aaa ChainsPickingScreen : onSpecTap');
                              value.blogSpec();
                              unit?.blogSpec();
                            },
                            onPickerTap: () => onGoToPickerScreen(
                              context: context,
                              zone: zone,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                              isMultipleSelectionMode: isMultipleSelectionMode,
                              onlyUseCityChains: onlyUseCityChains,
                              allPickers: allPickers,
                              picker: _picker,
                              refinedPickersNotifier: refinedPickersNotifier,
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
                            onlyUseCityChains: onlyUseCityChains,
                            zone: zone,

                            /// ON PHID TAP => ADD PHID
                            onPhidTap: (String path, String phid) => onSelectPhidInPickerScreen(
                              context: context,
                              phid: phid,
                              isMultipleSelectionMode: isMultipleSelectionMode,
                              selectedSpecsNotifier: selectedSpecsNotifier,
                              picker: PickerModel.getPickerByChainID(
                                pickers: allPickers,
                                chainID: ChainPathConverter.getFirstPathNode(path: Phider.removePathIndexes(path)),
                              ),
                            ),


                            onPhidDoubleTap: (String path, String phid) => blog('ChainsScreenSearchView : onPhidDoubleTap : $path : $phid'),
                            onPhidLongTap: (String path, String phid) => blog('ChainsScreenSearchView : onPhidLongTap : $path : $phid'),
                            onExportSpecs: (List<SpecModel> specs) => blog('ChainsScreenSearchView : specs : ${specs.length} specs'),
                            onDataCreatorKeyboardSubmitted: (String text){
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