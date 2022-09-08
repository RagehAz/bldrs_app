import 'dart:async';

import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class ChainsManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainsManagerState createState() => _ChainsManagerState();
  /// --------------------------------------------------------------------------
}

class _ChainsManagerState extends State<ChainsManager> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final List<FlyerType> _selectedTypes = <FlyerType>[];
  // --------------------
  static const List<FlyerType> _allTypes = <FlyerType>[
    // null,
    ...FlyerTyper.flyerTypesList,
  ];
  // --------------------
  void _onTapPickerSelector(FlyerType flyerType){

    final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
      flyerType: flyerType,
      flyerTypes: _selectedTypes,
    );

    if (_isSelected == true){
      setState(() {
        _selectedTypes.remove(flyerType);
      });
    }

    else {
      setState(() {
        _selectedTypes.insert(0, flyerType);
      });
    }

  }
  // --------------------
  bool onlyPhidKs = false;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
    // --------------------
    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      onBldrsTap: () async {

        // final dynamic _blha = await Real.readPath(context: context, path: 'chains');
        //
        // final List<Map<String, dynamic>> _maps = Mapper.getMapsFromInternalHashLinkedMapObjectObject(internalHashLinkedMapObjectObject: _blha);
        //
        // Mapper.blogMaps(_maps);

        // await Real.cr

        // const String phid = 'phid_s_am_kidsPopo';
        // const int index = 555;
        //
        // final String _withIndex = Phider.addIndexToPhid(
        //   phid: phid,
        //   index: index,
        //   // overrideExisting: true,
        // );
        //
        // final bool _phidHasIndex = Phider.checkPhidHasIndex(_withIndex);
        //
        // final int oldIndex = Phider.getIndexFromPhid(phid);
        //
        // final String _withoutPhidAgain = Phider.removeIndexFromPhid(phid: phid);
        //
        // blog('x_withIndex : $_withIndex _phidHasIndex : $_phidHasIndex : newIndex : $index : oldIndex : $oldIndex : _withoutPhidAgain : $_withoutPhidAgain');
        //
        // // const String _curr = 'currency_egy';
        // final bool _isCurrency = Phider.checkVerseIsCurrency(phid);
        // blog('isCurrency : $_isCurrency');



        final List<Chain> _bldrsChains = ChainsProvider.proGetBldrsChains(
            context: context,
            onlyUseCityChains: false,
            listen: false,
        );

        final List<Chain> _withIndexes = Phider.createChainsIndexes(_bldrsChains);

        // Chain.blogChains(_withIndexes);

        // final Map<String, dynamic> _map = Chain.cipherBldrsChains(chains: _withIndexes);
        //
        // final List<Chain> _reChains = Chain.decipherBldrsChains(map: _map);
        //

        final List<Chain> _uploaded = await ChainProtocols.composeBldrsChains(
            context: context,
            chains: _withIndexes,
        );

        final bool _areIdenticalOld = Chain.checkChainsListsAreIdentical(
          chains1: Phider.sortChainsByIndexes(_withIndexes),
          chains2: Phider.sortChainsByIndexes(_uploaded),
        );

        final bool _areIdenticalPaths = Chain.checkChainsListPathsAreIdentical(
            chains1: Phider.sortChainsByIndexes(_withIndexes),
            chains2: Phider.sortChainsByIndexes(_uploaded),
        );

        blog('xx _areIdenticalOld : $_areIdenticalOld : _areIdenticalPaths : $_areIdenticalPaths');


      },
      appBarWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.keyword,
          verse: onlyPhidKs == true ? 'Only phidKs' : 'All Chains',
          buttonColor: onlyPhidKs == true ? Colorz.yellow255 : null,
          verseColor: onlyPhidKs == true ? Colorz.black255 : Colorz.white255,
          onTap: (){

            setState(() {
              onlyPhidKs = !onlyPhidKs;
            });

          },
        ),

      ],
      listWidgets: <Widget>[

        // ---------------------------------------

        /// FLYER TYPE
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse:  'Flyer Type',
        ),

        /// PICKERS SELECTORS
        SizedBox(
          width: Scale.superScreenWidth(context),
          height: Ratioz.appBarButtonSize + 5,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _allTypes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){

                final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
                  flyerType: _allTypes[index],
                  flyerTypes: _selectedTypes,
                );

                return AppBarButton(
                  verse: _allTypes[index].toString(),
                  buttonColor: _isSelected == true ? Colorz.green255 : null,
                  onTap: () => _onTapPickerSelector(_allTypes[index]),
                );

              }
          ),
        ),

        // ---------------------------------------

        const SeparatorLine(),

        /// FLYER TYPE
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse:  'View Chains',
        ),

        /// CITY CHAINS + MULTIPLE SELECTION
        WideButton(
          translate: false,
          verse:  'CITY CHAINS + MULTIPLE SELECTION',
          onTap: () async {

            final List<SpecModel> _specs =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: true,
                  pageTitleVerse:  'CITY CHAINS + MULTIPLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                  zone: _currentZone,
                )
            );

            blog('CITY CHAINS + MULTIPLE SELECTION : List<SpecModel> ');
            SpecModel.blogSpecs(_specs);

          },
        ),

        /// ALL CHAINS + MULTIPLE SELECTION
        WideButton(
          translate: false,
          verse:  'ALL CHAINS + MULTIPLE SELECTION',
          color: Colorz.bloodTest,
          onTap: () async {

            final List<SpecModel> _specs =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: true,
                  pageTitleVerse:  'ALL CHAINS + MULTIPLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                  zone: _currentZone,
                )
            );

            blog('ALL CHAINS + MULTIPLE SELECTION : List<SpecModel>');
            SpecModel.blogSpecs(_specs);

          },
        ),

        /// CITY CHAINS + SINGLE SELECTION
        WideButton(
          translate: false,
          verse:  'CITY CHAINS + SINGLE SELECTION',
          color: Colorz.bloodTest,
          onTap: () async {

            final String string =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: false,
                  pageTitleVerse:  'CITY CHAINS + SINGLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                  zone: _currentZone,
                )
            );

            blog('CITY CHAINS + SINGLE SELECTION : string : $string');

          },
        ),

        /// ALL CHAINS + SINGLE SELECTION
        WideButton(
          translate: false,
          verse:  'ALL CHAINS + SINGLE SELECTION',
          onTap: () async {

            final String string =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: false,
                  pageTitleVerse:  'ALL CHAINS + SINGLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                  zone: _currentZone,
                )
            );

            blog('ALL CHAINS + SINGLE SELECTION : string : $string');

          },
        ),

        // ---------------------------------------

        const SeparatorLine(),

        /// VIEWING PRO CHAINS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse:  'Chain Real Ops',
        ),

        /// CREATE BLDRS CHAIN
        WideButton(
          translate: false,
          isActive: false,
          verse:  'CREATE BLDRS CHAIN',
          color: Colorz.blue80,
          onTap: () async {

            // final bool _continue = await CenterDialog.showCenterDialog(
            //   context: context,
            //   titleVerse:  'Create new Chain ?',
            //   bodyVerse:  'This will Create a new chain from pro chain and upload it to real db,, wanna continue ?',
            //   boolDialog: true,
            //   color: Colorz.bloodTest,
            // );
            //
            // if (_continue == true){
            //
            //   final Chain chainK = ChainsProvider.proGetBldrsChains(
            //       context: context,
            //       onlyUseCityChains: false,
            //       listen: false
            //   );
            //
            //   final Chain _chainKUploaded = await ChainProtocols.composeChainK(
            //       context: context,
            //       chainK: chainK
            //   );
            //
            //   if (_chainKUploaded == null){
            //     blog('No ChainK received');
            //   }
            //
            //   else {
            //     await Nav.goToNewScreen(
            //       context: context,
            //       screen: ChainEditorScreen(
            //         chain: _chainKUploaded,
            //       ),
            //     );
            //   }
            //
            // }

          },
        ),


        /// READ CHAIN K
        WideButton(
          translate: false,
          verse:  'READ BigChainK',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final List<Chain> _bldrsChains = await ChainRealOps.readBldrsChains(context);

            Chain.blogChains(_bldrsChains);

            WaitDialog.closeWaitDialog(context);

            if (_bldrsChains == null){
              blog('No ChainK found');
            }

            else {
              // await Nav.goToNewScreen(
              //   context: context,
              //   screen: ChainEditorScreen(
              //     chain: _bldrsChains,
              //   ),
              // );
            }

          },
        ),


        /// FETCH CHAINS
        WideButton(
          translate: false,
          verse:  'FETCH Bldrs Chains',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains(context);

            Chain.blogChains(_bldrsChains);

            WaitDialog.closeWaitDialog(context);

            if (_bldrsChains == null){
              blog('No ChainK found');
            }

            else {
              // await Nav.goToNewScreen(
              //   context: context,
              //   screen: ChainEditorScreen(
              //     chain: _bldrsChains,
              //   ),
              // );
            }

          },
        ),

        // ---------------------------------------

        const SeparatorLine(),

        const Horizon(),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
