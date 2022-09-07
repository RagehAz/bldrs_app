import 'dart:async';

import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
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
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_editor_screen.dart';
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

        // const String phid = 'phid_s_am_kidsPoo';




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

        /// CREATE CHAIN K
        WideButton(
          translate: false,
          isActive: false,
          verse:  'CREATE BigChainK from ProChainK',
          color: Colorz.blue80,
          onTap: () async {

            final bool _continue = await CenterDialog.showCenterDialog(
              context: context,
              titleVerse:  'Create new Chain ?',
              bodyVerse:  'This will Create a new chain from pro chain and upload it to real db,, wanna continue ?',
              boolDialog: true,
              color: Colorz.bloodTest,
            );

            if (_continue == true){

              final Chain chainK = ChainsProvider.proGetBigChainK(
                  context: context,
                  onlyUseCityChains: false,
                  listen: false
              );

              final Chain _chainKUploaded = await ChainProtocols.composeChainK(
                  context: context,
                  chainK: chainK
              );

              if (_chainKUploaded == null){
                blog('No ChainK received');
              }

              else {
                await Nav.goToNewScreen(
                  context: context,
                  screen: ChainEditorScreen(
                    chain: _chainKUploaded,
                  ),
                );
              }

            }

          },
        ),

        /// CREATE CHAIN S
        WideButton(
          translate: false,
          isActive: false,
          verse:  'CREATE BigChainS from ProChainS',
          color: Colorz.blue80,
          onTap: () async {

            final bool _continue = await CenterDialog.showCenterDialog(
              context: context,
              titleVerse:  'Create new Chain ?',
              bodyVerse:  'This will Create a new chain from pro chain and upload it to real db,, wanna continue ?',
              boolDialog: true,
              color: Colorz.bloodTest,
            );

            if (_continue == true){

              final Chain chainS = ChainsProvider.proGetBigChainS(
                  context: context,
                  listen: false
              );

              final Chain _chainSUploaded = await ChainProtocols.composeChainS(
                  context: context,
                  chainS: chainS
              );

              if (_chainSUploaded == null){
                blog('No ChainS received');
              }

              else {
                await Nav.goToNewScreen(
                  context: context,
                  screen: ChainEditorScreen(
                    chain: _chainSUploaded,
                  ),
                );
              }

            }

          },
        ),

        /// READ CHAIN K
        WideButton(
          translate: false,
          verse:  'READ BigChainK',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final Chain _bigChainK = await ChainRealOps.readBigChainK(context);

            WaitDialog.closeWaitDialog(context);

            if (_bigChainK == null){
              blog('No ChainK found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainEditorScreen(
                  chain: _bigChainK,
                ),
              );
            }

          },
        ),

        /// READ CHAIN S
        WideButton(
          translate: false,
          verse:  'READ BigChainS',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final Chain _bigChainS = await ChainRealOps.readBigChainS(context);

            WaitDialog.closeWaitDialog(context);

            if (_bigChainS == null){
              blog('No ChainS found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainEditorScreen(
                  chain: _bigChainS,
                ),
              );
            }

          },
        ),

        /// FETCH CHAIN K
        WideButton(
          translate: false,
          verse:  'FETCH BigChainK',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final Chain _bigChainK = await ChainProtocols.fetchBigChainK(context);

            WaitDialog.closeWaitDialog(context);

            if (_bigChainK == null){
              blog('No ChainK found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainEditorScreen(
                  chain: _bigChainK,
                ),
              );
            }

          },
        ),

        /// READ CHAIN S
        WideButton(
          translate: false,
          verse:  'FETCH BigChainS',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final Chain _bigChainS = await ChainProtocols.fetchBigChainS(context);

            WaitDialog.closeWaitDialog(context);

            if (_bigChainS == null){
              blog('No ChainS found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainEditorScreen(
                  chain: _bigChainS,
                ),
              );
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
